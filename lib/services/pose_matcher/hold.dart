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
      95.605484245588,
      160.7578455508976,
    ],
    [
      146.71801261363987,
      97.14770266305602,
    ]
  ];

  final List<double> tolerance = [10.0, 10.0];



  // int _targetReps = 10;
  // int get targetReps => _targetReps;

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
      return angle > 140 && angle < 640; 
    }

    bool isLeftLegStill = isLegStill(poseValues[0]);
    // print('isLeftLegStill: $isLeftLegStill');
    bool isRightLegStill = isLegStill(poseValues[1]);
    // print('isRightLegStill: $isRightLegStill');

    print('poseValues: $poseValues');
    
    //If < tol & > 0 then its true OR if < 0 or > tol then its false
    bool isLeftMatched() {
      
      // poseValues.toList().asMap().entries.forEach((entry) {
      //   final difference = (entry.value - leftRefAngle[entry.key]);
      //   print('${entry.key}: ${difference}');
      // });

      // print(poseValues.toList().asMap().entries.every((entry) => ((entry.value - leftRefAngle[1]) < [90,0][entry.key])));
      // print(poseValues.toList().asMap().entries.every((entry) => ((entry.value - leftRefAngle[entry.key]).abs() > tolerance[entry.key])));

      
      if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - leftRefAngle[entry.key]).abs() < tolerance[entry.key])) {
        return true;
      } 
      // else if (poseValues.toList().asMap().entries.every((entry) =>
      //     (entry.value - leftRefAngle[entry.key]).abs() > tolerance[entry.key] 
      //     && (entry.value - leftRefAngle[entry.key]) > [90,0][entry.key])) {
      //   message = "Lower your left leg";
      //   errorLines.addAll([
      //     [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
      //     [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
      //   ]);
      //   messageType = 'error';
      //   return false;
      // } 
      // else if (poseValues.toList().asMap().entries.every((entry) =>
      //     (entry.value - leftRefAngle[entry.key]).abs() > tolerance[entry.key]
      //     && (entry.value - leftRefAngle[entry.key]) < [90,0][entry.key])) {
      //   message = "Raise your left leg";
      //   errorLines.addAll([
      //     [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
      //     [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
      //   ]);
      //   messageType = 'error';
      //   return false;
      // }
      else {
        return false;
      }
    }

    bool isRightMatched() {
      
      // poseValues.toList().asMap().entries.forEach((entry) {
      //   final difference = (entry.value - leftRefAngle[entry.key]);
      //   print('${entry.key}: ${difference}');
      // });

      // print(poseValues.toList().asMap().entries.every((entry) => ((entry.value - leftRefAngle[1]) < [90,0][entry.key])));
      // print(poseValues.toList().asMap().entries.every((entry) => ((entry.value - leftRefAngle[entry.key]).abs() > tolerance[entry.key])));

      
      if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - rightRefAngle[entry.key]).abs() < tolerance[entry.key]
      )) {
        return true;
      } 
      else if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - rightRefAngle[entry.key]).abs() > tolerance[entry.key]
          && (entry.value - rightRefAngle[entry.key]) > [90,0][entry.key])) {
        message = "Lower your right leg";
        errorLines.addAll([
          [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
          [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
        ]);
        messageType = 'error';
        return false;
      } 
      else if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - rightRefAngle[entry.key]).abs() > tolerance[entry.key]
          && (entry.value - rightRefAngle[entry.key]) < [90,0][entry.key])) {
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
    
    // print('isMatched: $isMatched()');
    // print(isRightLegStill);
    // print(isLeftLegStill);

    return {
      'isLeftMatched': isLeftMatched(),
      'isRightMatched': isRightMatched(),
      'isLeftLegStill': isLeftLegStill,
      'isRightLegStill': isRightLegStill,
      'message': message,
      'messageType': messageType,
      'errorLines': errorLines,
    };
  }
}
