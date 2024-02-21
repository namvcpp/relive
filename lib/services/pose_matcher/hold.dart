import 'dart:ffi';

import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_matcher/utils.dart';

enum MoveStateType { still, down, up, none }

class PastValues {
  List<double> kneeLeftAngle = [];
  List<double> kneeRightAngle = [];

  List<double> averageValues(List<double> newValues) {
    if (kneeLeftAngle.length > 9) {
      kneeLeftAngle.removeAt(0);
      kneeRightAngle.removeAt(0);
    }

    kneeLeftAngle.add(newValues[0]);
    kneeRightAngle.add(newValues[1]);

    return [
      kneeLeftAngle.reduce((a, b) => a + b) / kneeLeftAngle.length,
      kneeRightAngle.reduce((a, b) => a + b) / kneeRightAngle.length,
    ];
  }
}

class HoldPoseMatcher {
  final List<List<double>> _referencePoseValues = [
    [
      102.605484245588,
      155.7578455508976,
    ],
    [
      162.71801261363987,
      103.14770266305602,
    ]
  ];

  final List<double> tolerance = [10.0, 10.0];

  int _currentRefPoseIndex = 0;
  int _reps = 0;

  int _poseCount = 0;
  double _tempMoveValue = 0;
  MoveStateType moveState = MoveStateType.none;

  int _passCount = 0;

  int _targetReps = 10;
  int get targetReps => _targetReps;

  PastValues pastValues = PastValues();

  HoldPoseMatcher();

  // Create a method to compute pose values
  List<double> _computePoseValues(Pose pose) {
    final PoseLandmark leftHip = pose.worldLandmarks[PoseLandmarkType.leftHip]!;
    final PoseLandmark rightHip =
        pose.worldLandmarks[PoseLandmarkType.rightHip]!;
    final PoseLandmark leftKnee =
        pose.worldLandmarks[PoseLandmarkType.leftKnee]!;
    final PoseLandmark rightKnee =
        pose.worldLandmarks[PoseLandmarkType.rightKnee]!;
    final PoseLandmark leftAnkle =
        pose.worldLandmarks[PoseLandmarkType.leftAnkle]!;
    final PoseLandmark rightAnkle =
        pose.worldLandmarks[PoseLandmarkType.rightAnkle]!;

    final double kneeLeftAngle = angleCalculate(leftHip, leftKnee, leftAnkle);
    final double kneeRightAngle =
        angleCalculate(rightHip, rightKnee, rightAnkle);

    return pastValues.averageValues([
      kneeLeftAngle,
      kneeRightAngle,
    ]);
  }

  Map<String, dynamic> compareWithReferencePoses(Pose pose) {
    final List<double> poseValues = _computePoseValues(pose);

    List<double> leftRefAngle = _referencePoseValues[0];
    List<double> rightRefAngle = _referencePoseValues[1];

    final List<List<PoseLandmarkType>> errorLines = [];
    String message = '';
    String messageType = '';

    List<double> poseValue = poseValues
            .toList()
            .asMap()
            .entries
            .map((entry) => (entry.value))
            .toList();

    bool isLegStill(double angle) {
      return angle > 140 && angle < 360; 
    }

    bool isLeftLegStill = isLegStill(poseValues[0]);
    // print('isLeftLegStill: $isLeftLegStill');
    bool isRightLegStill = isLegStill(poseValues[1]);
    // print('isRightLegStill: $isRightLegStill');


    //If the angle is approx 180 then that leg is still, then dont calculate that
    
    //If < tol & > 0 then its true OR if < 0 or > tol then its false
    bool isMatched() {
      if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - leftRefAngle[entry.key]).abs() < tolerance[entry.key] 
          && (entry.value - leftRefAngle[entry.key]) > 0)) {
        return true;
      } 
      else if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - rightRefAngle[entry.key]).abs() < tolerance[entry.key]
          && (entry.value - rightRefAngle[entry.key]) > 0)) {
        return true;
      } 
      else if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - leftRefAngle[entry.key]).abs() > tolerance[entry.key])) {
        message = "Lower your left leg";
        errorLines.addAll([
          [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
          [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
        ]);
        messageType = 'error';
        return false;
      } 
      else if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - rightRefAngle[entry.key]).abs() > tolerance[entry.key])) {
        message = "Lower your right leg";
        errorLines.addAll([
          [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
          [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
        ]);
        messageType = 'error';
        return false;
      } 
      else if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - leftRefAngle[entry.key]).abs() < 0)) {
        message = "Raise your left leg";
        errorLines.addAll([
          [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
          [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
        ]);
        messageType = 'error';
        return false;
      }
      else if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - rightRefAngle[entry.key]).abs() < 0)) {
        message = "Raise your right leg";
        errorLines.addAll([
          [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
          [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
        ]);
        messageType = 'error';
        return false;
      } 
      else {
        return false;
      }
    }

    // print(isMatched());
    // print(isRightLegStill);
    // print(isLeftLegStill);

    return {
      'isMatched': isMatched(),
      'isLegStill': isLeftLegStill,
      'isRightLegStill': isRightLegStill,
      'message': message,
      'messageType': messageType,
      'errorLines': errorLines,
    };
  }
}
