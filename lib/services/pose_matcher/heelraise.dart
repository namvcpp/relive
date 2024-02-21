import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_matcher/utils.dart';

enum MoveStateType { still, down, up, none }

class PastValues {
  List<double> ankleLeftAngle = [];
  List<double> ankleRightAngle = [];
  List<double> kneeLeftAngle = [];
  List<double> kneeRightAngle = [];

  List<double> averageValues(List<double> newValues) {
    if (ankleLeftAngle.length > 9) {
      ankleLeftAngle.removeAt(0);
      ankleRightAngle.removeAt(0);
      kneeLeftAngle.removeAt(0);
      kneeRightAngle.removeAt(0);
    }

    ankleLeftAngle.add(newValues[0]);
    ankleRightAngle.add(newValues[1]);
    kneeLeftAngle.add(newValues[2]);
    kneeRightAngle.add(newValues[3]);

    return [
      ankleLeftAngle.reduce((a, b) => a + b) / ankleLeftAngle.length,
      ankleRightAngle.reduce((a, b) => a + b) / ankleRightAngle.length,
      kneeLeftAngle.reduce((a, b) => a + b) / kneeLeftAngle.length,
      kneeRightAngle.reduce((a, b) => a + b) / kneeRightAngle.length,
    ];
  }
}

class HeelRaisePoseMatcher {
  final List<List<double>> _referencePoseValues = [
    [
      105.61938735674273, 114.97330176168109, 160.0, 160.0
    ],
    [
      107.42088453918436, 116.34062901572273, 160.0, 160.0
    ],
    [
      109.1996247480541, 118.69510578115474, 160.0, 160.0
    ],
    [
      111.57488191656253, 121.41385017920493, 160.0, 160.0
    ],
    [
      109.1596222015913, 118.55636597651915, 160.0, 160.0
    ],
    [
      107.02940815781672, 116.28490969765683, 160.0, 160.0
    ],
    [
      105.5460444514293, 114.39071224361548, 160.0, 160.0
    ]
  ];

  final List<double> tolerance = [5.0, 5.0, 10.0, 10.0];

  int _currentRefPoseIndex = 0;
  int _reps = 0;

  int _poseCount = 0;
  double _tempMoveValue = 0;
  MoveStateType moveState = MoveStateType.none;

  int _passCount = 0;

  int _targetReps = 10;
  int get targetReps => _targetReps;
  int get reps => _reps;

  PastValues pastValues = PastValues();

  HeelRaisePoseMatcher();

  // Create a method to compute pose values
  List<double> _computePoseValues(Pose pose) {
    final PoseLandmark leftFootIndex = pose.worldLandmarks[PoseLandmarkType.leftFootIndex]!;
    final PoseLandmark rightFootIndex =
        pose.worldLandmarks[PoseLandmarkType.rightFootIndex]!;
    final PoseLandmark leftKnee =
        pose.worldLandmarks[PoseLandmarkType.leftKnee]!;
    final PoseLandmark rightKnee =
        pose.worldLandmarks[PoseLandmarkType.rightKnee]!;
    final PoseLandmark leftAnkle =
        pose.worldLandmarks[PoseLandmarkType.leftAnkle]!;
    final PoseLandmark rightAnkle =
        pose.worldLandmarks[PoseLandmarkType.rightAnkle]!;
    final PoseLandmark leftHip =
        pose.worldLandmarks[PoseLandmarkType.leftHip]!;
    final PoseLandmark rightHip =
        pose.worldLandmarks[PoseLandmarkType.rightHip]!;

    final double ankleLeftAngle = 
        angleCalculate(leftKnee, leftAnkle, leftFootIndex);
    final double ankleRightAngle =
        angleCalculate(rightKnee, rightAnkle, rightFootIndex);

    final double kneeLeftAngle = 
        angleCalculate(leftHip, leftKnee, leftAnkle);
    final double kneeRightAngle =
        angleCalculate(rightHip, rightKnee, rightAnkle);

    return pastValues.averageValues([
      ankleLeftAngle,
      ankleRightAngle,
      kneeLeftAngle,
      kneeRightAngle,
    ]);
  }

  List<List<PoseLandmarkType>> compareWithReferencePoses(Pose pose) {
    final List<double> poseValues = _computePoseValues(pose);
    final List<List<PoseLandmarkType>> errorLines = [];
    String message = '';
    String messageType = '';

    if (_tempMoveValue == 0) {
      moveState = MoveStateType.none;
    } else if (_poseCount % 4 == 0) {
      if ((poseValues[0] - _tempMoveValue) < 0) {
        moveState = MoveStateType.down;
      } else if (poseValues[0] - _tempMoveValue < 0.4) {
        moveState = MoveStateType.still;
      } else {
        moveState = MoveStateType.up;
      }
    }

    _tempMoveValue = poseValues[0];

    print('$poseValues, $moveState, $_passCount, $_reps');

    // Check against reference angles
    for (int i = _passCount; i < _referencePoseValues.length; i++) {
      List<double> refAngle = _referencePoseValues[i];
      
      if (poseValues.toList().asMap().entries.every((entry) =>
          (entry.value - refAngle[entry.key]).abs() < tolerance[entry.key])) {
        if (_passCount < 5 && moveState == MoveStateType.up ||
            _passCount >= 5 && moveState == MoveStateType.down) {
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
          message = 'Mind your left ankle';
          // errorLines.addAll([
          //   [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
          //   [PoseLandmarkType.leftAnkle, PoseLandmarkType.leftFootIndex]
          // ]);
          // messageType = 'error';
        }

        // Check state of right elbow angle
        if (diff[1].abs() > tolerance[1]) {
          message = 'Mind your right ankle';
          // errorLines.addAll([
          //   [PoseLandmarkType.rightKnee, PoseLandmarkType.rightKnee],
          //   [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
          // ]);
        }
      }

      if (_passCount == _referencePoseValues.length - 1) {
        _passCount = 0;
        _reps++;
        message = 'Good job! You have completed $_reps reps';
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