import 'dart:io';

import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_matcher/utils.dart';

enum MoveStateType { still, down, up, none }

enum PoseType { left, right }

class PastValues {
  List<List<double>> anglesValueList;

  PastValues(numOfAngles)
      : anglesValueList = List.generate(numOfAngles, (_) => []);

  List<double> averageValues(List<double> newValues) {
    if (anglesValueList.first.length > 9) {
      // every ele in the list remove the first ele
      for (var element in anglesValueList) {
        element.removeAt(0);
      }
    }

    for (var i = 0; i < newValues.length; i++) {
      anglesValueList[i].add(newValues[i]);
    }

    return anglesValueList
        .map((e) => e.reduce((a, b) => a + b) / e.length)
        .toList();
  }
}

class MarchPoseMatcher {
  final List<List<double>> _referencePoseValues = [
    [
      152.89632509929393,
      154.40253814104256,
    ],
    [
      147.7321687846604,
      78.66029955089378,
    ],
    [
      71.21017196168039,
      155.8054675739652,
    ]
  ];

  final List<double> tolerance = [20.0, 20.0];

  int _currentRefPoseIndex = 0;
  int _reps = 0;

  int _poseCount = 0;
  double _tempMoveValue_left = 0;
  double _tempMoveValue_right = 0;
  MoveStateType moveState = MoveStateType.none;
  PoseType poseType = PoseType.right;

  int _passCount = 0;

  int _targetReps = 10;
  int get targetReps => _targetReps;
  int get reps => _reps;

  late PastValues pastValues;

  MarchPoseMatcher();

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

    pastValues = PastValues(2);

    return pastValues.averageValues([
      kneeLeftAngle,
      kneeRightAngle,
    ]);
  }

  List<PoseType> correctFeet = [];
  List<List<PoseLandmarkType>> errorLines = [];

  Map<String, dynamic> compareWithReferencePoses(Pose pose) {
    final List<double> poseValues = _computePoseValues(pose);

    List<double> refAngle_0 = _referencePoseValues[0];
    List<double> refAngle_1 = _referencePoseValues[1];
    List<double> refAngle_2 = _referencePoseValues[2];

    if (poseValues.toList().asMap().entries.every((entry) =>
        (entry.value - refAngle_1[entry.key]).abs() < tolerance[entry.key])) {
      if (!correctFeet.contains(PoseType.right)) {
        correctFeet.add(PoseType.right);
        errorLines.addAll([
          [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
          [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
        ]);
      }
    }

    if (poseValues.toList().asMap().entries.every((entry) =>
        (entry.value - refAngle_2[entry.key]).abs() < tolerance[entry.key])) {
      if (!correctFeet.contains(PoseType.left)) {
        correctFeet.add(PoseType.left);
        errorLines.addAll([
          [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
          [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
        ]);
      }
    }

    if (poseValues.toList().asMap().entries.every((entry) =>
        (entry.value - refAngle_0[entry.key]).abs() < tolerance[entry.key])) {
      if (correctFeet.length == 2) {
        _reps++;
        correctFeet = [];
        errorLines = [];
      }
    }

    print("Pose values: $poseValues");

    // String message = '';
    // String messageType = '';
    // if ((poseValues[0] - _tempMoveValue_left).abs() < 2) {
    //   poseType = PoseType.left;
    // } else {
    //   poseType = PoseType.right;
    // }

    // if (poseType == PoseType.left) {
    // if (_tempMoveValue_left == 0) {
    //   moveState = MoveStateType.none;
    // } else if (_poseCount % 10 == 0) {
    //   if ((poseValues[0] - _tempMoveValue_left).abs() < 2) {
    //     moveState = MoveStateType.still;
    //   } else if (poseValues[0] - _tempMoveValue_left < 0) {
    //     moveState = MoveStateType.up;
    //   } else {
    //     moveState = MoveStateType.down;
    //   }
    // } else {
    //   if (_tempMoveValue_right == 0) {
    //     moveState = MoveStateType.none;
    //   } else if (_poseCount % 10 == 0) {
    //     if ((poseValues[1] - _tempMoveValue_right).abs() < 2) {
    //       moveState = MoveStateType.still;
    //     } else if (poseValues[1] - _tempMoveValue_right < 0) {
    //       moveState = MoveStateType.up;
    //     } else {
    //       moveState = MoveStateType.down;
    //     }
    //   }
    // }
    // }
    // _tempMoveValue_left = poseValues[0];
    // _tempMoveValue_right = poseValues[1];

    // if (poseType == PoseType.right) {
    //   if (poseValues.toList().asMap().entries.every((entry) =>
    //       (entry.value - _referencePoseValues[0][entry.key]).abs() <
    //       tolerance[entry.key])) {
    //     errorLines.addAll([
    //       [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
    //       [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
    //     ]);

    //     if (poseValues.toList().asMap().entries.every((entry) =>
    //         (entry.value - _referencePoseValues[1][entry.key]).abs() <
    //         tolerance[entry.key])) {
    //       _reps++;
    //       errorLines.addAll([
    //         [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
    //         [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
    //       ]);
    //     }
    //   }
    // } else {
    //   if (poseValues.toList().asMap().entries.every((entry) =>
    //       (entry.value - _referencePoseValues[1][entry.key]).abs() <
    //       tolerance[entry.key])) {
    //     errorLines.addAll([
    //       [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
    //       [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
    //     ]);
    //     if (poseValues.toList().asMap().entries.every((entry) =>
    //         (entry.value - _referencePoseValues[0][entry.key]).abs() <
    //         tolerance[entry.key])) {
    //       _reps++;
    //       errorLines.addAll([
    //         [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
    //         [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
    //       ]);
    //     }
    //   }
    // }
    return {
      'errorLines': errorLines,
      // 'messageType': messageType, // 'reps' or 'message
      // 'message': message
    };
  }
}
