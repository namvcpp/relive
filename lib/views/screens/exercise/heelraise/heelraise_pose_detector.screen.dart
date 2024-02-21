import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_matcher/heelraise.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/screens/exercise/camera_native.screen.dart';
import 'package:fit_worker/views/screens/exercise/exercise.flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fit_worker/services/pose_painter/pose_painter.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fit_worker/views/components/exercise/repCountPane.dart';

class HeelRaisePoseDetectorView extends StatefulWidget {
  const HeelRaisePoseDetectorView({super.key});

  @override
  State<StatefulWidget> createState() => _HeelRaisePoseDetectorViewState();
}

class _HeelRaisePoseDetectorViewState extends State<HeelRaisePoseDetectorView> {
  bool _canProcess = true;
  CustomPaint? _customPaint;

  final HeelRaisePoseMatcher _poseMatcher = HeelRaisePoseMatcher();

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

  @override
  void initState() {
    super.initState();

    _poseSubscription =
        poseChannel.receiveBroadcastStream().listen((dynamic event) {
      _poseData = PoseData.fromMap(event);

      if (!_poseData!.pose.allPoseLandmarksAreInFrame()) {
        _customPaint = null;
      } else {
        List<List<PoseLandmarkType>> errorLines =
            _poseMatcher.compareWithReferencePoses(_poseData!.pose);

        _updateCustomPaint(errorLines);
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
  void _updateCustomPaint(List<List<PoseLandmarkType>> errorLines) {
    if (_poseData != null) {
      // Check if all the pose landmarks coordinates are in the range 0, 1
      // If not, then the pose is not in the frame and _customPaint is set to null
      final painter = PosePainter(
          [_poseData!.pose],
          _poseData!.inputImageSize,
          InputImageRotation.rotation270deg,
          CameraLensDirection.front,
          errorLines);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
      // TODO: Notify user to wait
    }
  }

  Widget repsCountPane() => Positioned(
        top: 80,
        right: 80,
        left: 80,
        child: RepsCountPane(currentReps: _poseMatcher.reps, targetReps: _poseMatcher.targetReps,)
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
