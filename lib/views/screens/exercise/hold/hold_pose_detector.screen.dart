import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fit_worker/services/pose_painter/hold_pose_painter.dart';
import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_matcher/hold.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/screens/exercise/camera_native.screen.dart';
import 'package:fit_worker/views/screens/exercise/exercise.flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fit_worker/views/components/exercise/timeCountPane.dart';

class HoldPoseDetectorView extends StatefulWidget {
  const HoldPoseDetectorView({super.key});

  @override
  State<StatefulWidget> createState() => _HoldPoseDetectorViewState();
}

class _HoldPoseDetectorViewState extends State<HoldPoseDetectorView> {
  bool _canProcess = true;
  CustomPaint? _customPaint;

  late Timer _timer;

  final HoldPoseMatcher _poseMatcher = HoldPoseMatcher();

  static const EventChannel poseChannel =
      EventChannel('fit_worker/pose_data_stream');

  late StreamSubscription _poseSubscription;
  PoseData? _poseData;

  @override
  void dispose() async {
    super.dispose();
    _canProcess = false;
    _poseSubscription.cancel();
    _customPaint = null;
    _poseData = null;
    _stopLeftTimer();
    _stopRightTimer();
  }

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }

  int _leftTargetDuration = 5; // Set the initial timer duration in seconds
  int _rightTargetDuration = 5; // Set the initial timer duration in seconds


  int _leftTimerDuration = 0; // Set the initial timer duration in seconds
  bool _isLeftTimerRunning = false;
  bool _leftEnabled = true;

  void _startLeftTimer() {
    if (!_isLeftTimerRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _leftTimerDuration++;
        });
      });
      _isLeftTimerRunning = true;
    }
  }

  void _stopLeftTimer() {
    if (_isLeftTimerRunning) {
      _timer.cancel();
      _isLeftTimerRunning = false;
    }
  }

  int _rightTimeDuration = 0; // Set the initial timer duration in seconds
  bool _isRightTimerRunning = false;
  bool _rightEnabled = true;

  void _startRightTimer() {
    if (!_isRightTimerRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _rightTimeDuration++;
        });
      });
      _isRightTimerRunning = true;
    }
  }

  void _stopRightTimer() {
    if (_isRightTimerRunning) {
      _timer.cancel();
      _isRightTimerRunning = false;
    }
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void navigateToNextScreen() {
      ExerciseFlow.of(context).goToNextScreen();
  }

  @override
  void initState() {
    super.initState();

    _poseSubscription =
        poseChannel.receiveBroadcastStream().listen((dynamic event) {
      _poseData = PoseData.fromMap(event);

      if (!_poseData!.pose.allPoseLandmarksAreInFrame()) {
        _customPaint = null;
      } else {
        Map<String, dynamic> poseDataStream =
            _poseMatcher.compareWithReferencePoses(
          _poseData!.pose,
        );
        
        // print(poseDataStream);

        bool isLeftMatched = poseDataStream['isLeftMatched'] ?? false;
        bool isRightMatched = poseDataStream['isRightMatched'] ?? false;
        bool isLeftLegStill = poseDataStream['isLeftLegStill'] ?? false;
        bool isRightLegStill = poseDataStream['isRightLegStill'] ?? false;

        _updateCustomPaint(poseDataStream['errorLines'], isLeftMatched, isRightMatched, isLeftLegStill, isRightLegStill);

        if (isLeftMatched && _leftEnabled) {
          _startLeftTimer();
          if (_leftTimerDuration == _leftTargetDuration) {
            _stopLeftTimer();
            _leftEnabled = false;
          } // Resume the timer when a valid pose is detected
        } else {
          _stopLeftTimer(); // Stop the timer when a valid pose is not detected
        }

        if ((_leftTimerDuration == _leftTargetDuration) && isRightMatched) {
          _startRightTimer();
          if (_rightTimeDuration == _rightTargetDuration) {
            _stopRightTimer();
            _rightEnabled = false;
            navigateToNextScreen();
          } // Resume the timer when a valid pose is detected
        } else {
          _stopRightTimer();
        }
      }

      setState(() {});
    });

    _getCameraPermission().then((status) {
      if (status.isGranted) {
        _canProcess = true;
      } else {
        _canProcess = false;
      }

      setState(() {});
    });
  }

  // Method to generate the CustomPaint when _poseData is not null
  void _updateCustomPaint(
      List<List<PoseLandmarkType>> errorLines,
      bool isLeftMatched, bool isRightMatched, bool isLeftLegStill, bool isRightLegStill) {
    if (_poseData != null) {
      final painter = HoldPosePainter(
          [_poseData!.pose],
          _poseData!.inputImageSize,
          InputImageRotation.rotation270deg,
          CameraLensDirection.front,
          errorLines,
          isLeftMatched,
          isRightMatched,
          isLeftLegStill,
          isRightLegStill);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
      // TODO: Notify user to wait
    }
  }

  Widget repsCountPane() => Positioned(
        top: 130,
        right: 80,
        left: 80,
        child: TimeCountPane(currentTime: _leftTimerDuration + _rightTimeDuration, targetTime: _leftTargetDuration + _rightTargetDuration),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Center(
          child: _canProcess
              ? Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    const CameraNativeView(),
                    _customPaint ?? Container(),
                    repsCountPane()
                  ],
                )
              : const Center(
                  child: Text('Camera permission is not granted'),
                ),
        ),
        Positioned(
          left: 10,
          top: 30,
          child: IconButton(
            icon: backIcon,
            onPressed: () => ExerciseFlow.of(context).goToPreviousScreen(),
          ),
        ),
      ],
    );
  }
}
