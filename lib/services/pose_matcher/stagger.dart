import 'dart:io';

import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_matcher/utils.dart';

enum MoveStateType { still, down, up, none }

enum PoseType { left, right }

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

class StaggerPoseMatcher {
  final List<List<double>> _referencePoseValues = [
    [
      96.23537854073734,
      89.09268150908218,
    ],
    [
      124.46131906030273,
      119.4967291307073,
    ],
    [
      152.84898913628743,
      154.93957137297897,
    ],
    [
      93.71437718552482,
      90.11163375721151,
    ],
  ];

  final List<double> tolerance = [15.0, 15.0];

  int _reps = 0;

  int _poseCount = 0;
  double _tempMoveValue = 0;
  MoveStateType moveState = MoveStateType.none;

  int _passCount = 0;

  int _targetReps = 5;
  int get targetReps => _targetReps;
  int get reps => _reps;

  PastValues pastValues = PastValues();

  StaggerPoseMatcher();

  // Create a method to compute pose values
  List<double> _computePoseValues(Pose pose) {
    // tobe done : calculate the distance between 2 angkle and shoulder
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
    final List<List<PoseLandmarkType>> errorLines = [];
    String message = '';
    String messageType = '';

    if (_tempMoveValue == 0) {
      moveState = MoveStateType.none;
    } else if (_poseCount % 8 == 0) {
      if ((poseValues[0] - _tempMoveValue).abs() < 2) {
        moveState = MoveStateType.still;
      } else if (poseValues[0] - _tempMoveValue < 0) {
        moveState = MoveStateType.down;
      } else {
        moveState = MoveStateType.up;
      }
    }

    _tempMoveValue = poseValues[0];

    for (int i = _passCount; i < _referencePoseValues.length; i++) {
      List<double> refAngle = _referencePoseValues[i];
      if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - refAngle[entry.key]).abs() < tolerance[entry.key])) {
        _passCount++;
      }

      String msg = "Pose values: $poseValues, Ref angle: $refAngle";

      if (_passCount == 2) {
        if (poseValues[1] - _referencePoseValues[2][1] < tolerance[1]) {
          // TODO: Change it later, quick fix
          errorLines.addAll([
            [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
            [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
            [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
            [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
          ]);
        }
      }

      if (_passCount == 3) {
        print(msg);
      }

      if (_passCount == _referencePoseValues.length) {
        print(msg);
        exit(0);
        _passCount = 0;
        _reps++;
        message = '$_reps';
        messageType = 'reps';
      }

      if (_passCount < _referencePoseValues.length &&
          _poseCount > 2 &&
          moveState == MoveStateType.still) {
        _passCount = 0;
      }
    }

    _poseCount++;
    print("Pass count: $_passCount, Move state: $moveState");

    return {
      'errorLines': errorLines,
      'messageType': messageType, // 'reps' or 'message
      'message': message
    };
  }
}
