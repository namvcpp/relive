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

class LungePoseMatcher {
  final List<List<double>> _referencePoseValues = [
    [
      158.3986006964505,
      160.64751554137442,
    ],
    [
      153.20008202402977,
      161.03341836660138,
    ],
    [
      149.5090122244325,
      152.9304989053898,
    ],
    [
      106.99695978822547,
      115.82063153163924,
    ],
    [
      106.14529384552046,
      117.27081066268217,
    ],
    [
      154.3152145632174,
      158.28816563818063,
    ],
    [
      151.9764452542696,
      158.51263641252888,
    ],
    [
      160.47809201081944,
      152.8975170549417,
    ],
    [
      106.68551532062885,
      119.36562415872187,
    ],
    [
      161.28997004253574,
      146.2477072521567,
    ],
    [
      153.9176120676448,
      161.26324532277633,
    ]
  ];

  final List<double> tolerance = [15.0, 15.0];

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

  LungePoseMatcher();

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

  List<List<PoseLandmarkType>> compareWithReferencePoses(Pose pose) {
    final List<double> poseValues = _computePoseValues(pose);
    final List<List<PoseLandmarkType>> errorLines = [];

    if (_tempMoveValue == 0) {
      moveState = MoveStateType.none;
    } else if (_poseCount % 10 == 0) {
      if ((poseValues[0] - _tempMoveValue).abs() < 2) {
        moveState = MoveStateType.still;
      } else if (poseValues[0] - _tempMoveValue < 0) {
        moveState = MoveStateType.down;
      } else {
        moveState = MoveStateType.up;
      }
    }

    _tempMoveValue = poseValues[0];

    print('$poseValues, $moveState');

    for (int i = _passCount; i < _referencePoseValues.length; i++) {
      List<double> refAngle = _referencePoseValues[i];

      if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - refAngle[entry.key]).abs() < tolerance[entry.key])) {
        if (_passCount < 4 && moveState == MoveStateType.down ||
            _passCount >= 4 &&
                _passCount < 7 &&
                moveState == MoveStateType.up ||
            _passCount >= 7 &&
                _passCount < 9 &&
                moveState == MoveStateType.down ||
            _passCount >= 9 && moveState == MoveStateType.up) {
          _passCount++;
        }
      } else {
        List<double> diff = poseValues
            .toList()
            .asMap()
            .entries
            .map((entry) => (entry.value - refAngle[entry.key]).abs())
            .toList();

        // Check state of left elbow angle
        if (diff[0].abs() > tolerance[0]) {
          String message = 'Mind your left knee';
          // errorLines.addAll([
          //   [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
          //   [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle]
          // ]);
        }

        // Check state of right elbow angle
        if (diff[1].abs() > tolerance[1]) {
          String message = 'Mind your right knee';
          // errorLines.addAll([
          //   [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
          //   [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
          // ]);
        }
      }

      if (_passCount == _referencePoseValues.length - 1) {
        _passCount = 0;
        _reps++;
        String message = 'Good job! You have completed $_reps reps';
      }

      // if (_passCount < _referencePoseValues.length - 1 &&
      //     _passCount > 4 &&
      //     moveState == MoveStateType.still) {
      //   _passCount = 0;
      // }
    }

    _poseCount++;

    return errorLines;
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
