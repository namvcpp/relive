import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_matcher/utils.dart';

enum MoveStateType { still, down, up, none }

class PastValues {
  List<double> elbowLeftAngle = [];
  List<double> elbowRightAngle = [];
  List<double> shoulderLeftAngle = [];
  List<double> shoulderRightAngle = [];
  List<double> kneeLeftAngle = [];
  List<double> kneeRightAngle = [];

  List<double> averageValues(List<double> newValues) {
    if (elbowLeftAngle.length > 4) {
      elbowLeftAngle.removeAt(0);
      elbowRightAngle.removeAt(0);
      shoulderLeftAngle.removeAt(0);
      shoulderRightAngle.removeAt(0);
      kneeLeftAngle.removeAt(0);
      kneeRightAngle.removeAt(0);
    }

    elbowLeftAngle.add(newValues[0]);
    elbowRightAngle.add(newValues[1]);
    shoulderLeftAngle.add(newValues[2]);
    shoulderRightAngle.add(newValues[3]);
    kneeLeftAngle.add(newValues[4]);
    kneeRightAngle.add(newValues[5]);

    return [
      elbowLeftAngle.reduce((a, b) => a + b) / elbowLeftAngle.length,
      elbowRightAngle.reduce((a, b) => a + b) / elbowRightAngle.length,
      shoulderLeftAngle.reduce((a, b) => a + b) / shoulderLeftAngle.length,
      shoulderRightAngle.reduce((a, b) => a + b) / shoulderRightAngle.length,
      kneeLeftAngle.reduce((a, b) => a + b) / kneeLeftAngle.length,
      kneeRightAngle.reduce((a, b) => a + b) / kneeRightAngle.length,
    ];
  }
}

class SquatPoseMatcher {
  final List<List<double>> _referencePoseValues = [
    [
      1.64566319e2,
      1.65426829e2,
      9.7480081e1,
      8.36205334e1,
      1.47215434e2,
      1.50791226e2,
    ],
    [
      1.61180652e2,
      1.65983236e2,
      1.00294241e2,
      8.39433279e1,
      1.44128993e2,
      1.52763967e2,
    ],
    [
      1.70762288e2,
      1.63882896e2,
      1.06351705e2,
      8.4941609e1,
      1.01209117e2,
      1.28780394e2,
    ],
    [
      1.74986412e2,
      1.60718109e2,
      1.05017051e2,
      9.0685085e1,
      8.37645627e1,
      1.01118596e2,
    ],
    [
      1.73198836e2,
      1.55574606e2,
      1.09034474e2,
      9.42085447e1,
      7.49683672e1,
      8.08804467e1,
    ],
    [
      1.73934198e2,
      1.62168753e2,
      1.08740501e2,
      9.74603711e1,
      8.23437311e1,
      9.17521242e1,
    ],
    [
      1.74415484e2,
      1.6261495e2,
      1.06699999e2,
      8.9327813e1,
      1.2151755e2,
      1.425552e2,
    ],
    [
      1.71880546e2,
      1.62862361e2,
      1.05359875e2,
      8.84977495e1,
      1.54443719e2,
      1.5807256e2,
    ]
  ];

  final List<double> tolerance = [30.0, 30.0, 25.0, 25.0, 20.0, 20.0];

  int _currentRefPoseIndex = 0;
  int _reps = 0;

  int _poseCount = 0;
  double _tempMoveValue = 0;
  MoveStateType moveState = MoveStateType.none;

  int _passCount = 0;

  int _targetReps = 5;
  int get targetReps => _targetReps;
  int get reps => _reps;

  PastValues pastValues = PastValues();

  SquatPoseMatcher();

  // Create a method to compute pose values
  List<double> _computePoseValues(Pose pose) {
    final PoseLandmark leftWrist =
        pose.worldLandmarks[PoseLandmarkType.leftWrist]!;
    final PoseLandmark rightWrist =
        pose.worldLandmarks[PoseLandmarkType.rightWrist]!;
    final PoseLandmark leftShoulder =
        pose.worldLandmarks[PoseLandmarkType.leftShoulder]!;
    final PoseLandmark rightShoulder =
        pose.worldLandmarks[PoseLandmarkType.rightShoulder]!;
    final PoseLandmark leftElbow =
        pose.worldLandmarks[PoseLandmarkType.leftElbow]!;
    final PoseLandmark rightElbow =
        pose.worldLandmarks[PoseLandmarkType.rightElbow]!;
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

    final double elbowLeftAngle =
        angleCalculate(leftWrist, leftElbow, leftShoulder);
    final double elbowRightAngle =
        angleCalculate(rightWrist, rightElbow, rightShoulder);
    final double shoulderLeftAngle =
        angleCalculate(leftElbow, leftShoulder, leftHip);
    final double shoulderRightAngle =
        angleCalculate(rightElbow, rightShoulder, rightHip);
    final double kneeLeftAngle = angleCalculate(leftHip, leftKnee, leftAnkle);
    final double kneeRightAngle =
        angleCalculate(rightHip, rightKnee, rightAnkle);

    return pastValues.averageValues([
      elbowLeftAngle,
      elbowRightAngle,
      shoulderLeftAngle,
      shoulderRightAngle,
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
      if ((poseValues[4] - _tempMoveValue).abs() < 2) {
        moveState = MoveStateType.still;
      } else if (poseValues[4] - _tempMoveValue < 0) {
        moveState = MoveStateType.down;
      } else {
        moveState = MoveStateType.up;
      }
    }

    _tempMoveValue = poseValues[4];

    for (int i = _passCount; i < _referencePoseValues.length; i++) {
      List<double> refAngle = _referencePoseValues[i];

      if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - refAngle[entry.key]).abs() < tolerance[entry.key])) {
        if (_passCount < 4 && moveState == MoveStateType.down ||
            _passCount >= 4 && moveState == MoveStateType.up) {
          _passCount++;
        }
      } else {
        List<double> diff = poseValues
            .toList()
            .asMap()
            .entries
            .map((entry) => (entry.value - refAngle[entry.key]))
            .toList();

        print('__________________________\n'
            'Knee Left Angle: ${poseValues[4]}\n'
            'Knee Right Angle: ${poseValues[5]}\n'
            '__________________________\n');

        // Check state of left elbow angle
        if (diff[0].abs() > tolerance[0]) {
          message = 'Maintain your left-elbow straightness';
          errorLines.addAll([
            [PoseLandmarkType.leftWrist, PoseLandmarkType.leftElbow],
            [PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder]
          ]);
          messageType = 'error';
        }

        // Check state of right elbow angle
        if (diff[1].abs() > tolerance[1]) {
          message = 'Maintain your right-elbow straightness';
          errorLines.addAll([
            [PoseLandmarkType.rightWrist, PoseLandmarkType.rightElbow],
            [PoseLandmarkType.rightElbow, PoseLandmarkType.rightShoulder]
          ]);
          messageType = 'error';
        }

        // Check state of left shoulder angle
        if (diff[2] < 0 && diff[2] < -tolerance[2]) {
          message = 'Raise your right shoulder';
          errorLines.addAll([
            [PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder],
            [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip]
          ]);
          messageType = 'error';
        }

        if (diff[2] > 0 && diff[2] > tolerance[2]) {
          message = 'Lower your right shoulder';
          errorLines.addAll([
            [PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder],
            [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip]
          ]);
          messageType = 'error';
        }

        // Check state of right shoulder angle
        if (diff[3] < 0 && diff[3] < -tolerance[3]) {
          message = 'Raise your left shoulder';
          errorLines.addAll([
            [PoseLandmarkType.rightElbow, PoseLandmarkType.rightShoulder],
            [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip]
          ]);
          messageType = 'error';
        }

        if (diff[3] > 0 && diff[3] > tolerance[3]) {
          message = 'Lower your left shoulder';
          errorLines.addAll([
            [PoseLandmarkType.rightElbow, PoseLandmarkType.rightShoulder],
            [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip]
          ]);
          messageType = 'error';
        }

        // Check state of left knee angle
        // if (diff[4] < 0.8 && diff[4] < (-tolerance[4] + 0.8) && _passCount < 4) {
        //   message = 'Move your left knee inward';
        //   errorLines.addAll([
        //     [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
        //     [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
        //   ]);
        //   messageType = 'error';
        // }

        // if (diff[4] < 0.8 && diff[4] < (-tolerance[4] + 0.8) && _passCount >= 4) {
        //   message = 'Move your left knee inward';
        //   errorLines.addAll([
        //     [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
        //     [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
        //   ]);
        //   messageType = 'error';
        // }

        // // Check state of right knee angle
        // if (diff[5] < 0.8 &&
        //     diff[5] < (-tolerance[5] + 0.8) &&
        //     _passCount < 4) {
        //   message = 'Move your right knee inward';
        //   errorLines.addAll([
        //     [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
        //     [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
        //   ]);
        //   messageType = 'error';
        // }
      }

      if (_passCount == 4) {
        if (poseValues[4] - _referencePoseValues[4][4] < tolerance[4]) {
          // TODO: Change it later, quick fix
          errorLines.addAll([
            [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
            [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
            [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
            [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
          ]);
        }
      }

      if (_passCount == _referencePoseValues.length - 1) {
        _passCount = 0;
        _reps++;
        message = '$_reps';
        messageType = 'reps';
      }

      if (_passCount < _referencePoseValues.length - 1 &&
          _passCount > 5 &&
          moveState == MoveStateType.still) {
        _passCount = 0;
      }
    }

    _poseCount++;

    return {
      'errorLines': errorLines,
      'messageType': messageType, // 'reps' or 'message
      'message': message
    };
  }

  // Method to check if the pose is in rest position
  bool isPoseInRestPosition(Pose pose) {
    final List<double> poseValues = _computePoseValues(pose);

    if (poseValues[2] < 45 && poseValues[3] < 45) {
      return true;
    } else {
      return false;
    }
  }

  String debugMessage() {
    String state;
    switch (moveState) {
      case MoveStateType.none:
        state = 'none';
        break;
      case MoveStateType.still:
        state = 'still';
        break;
      case MoveStateType.down:
        state = 'down';
        break;
      case MoveStateType.up:
        state = 'up';
        break;
    }
    return '$_reps, $_passCount, $state';
  }
}
