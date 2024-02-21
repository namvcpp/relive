import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_matcher/stagger.dart';
import 'package:fit_worker/services/pose_painter/stagger_pose_painter.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/screens/exercise/camera_native.screen.dart';
import 'package:fit_worker/views/screens/exercise/hold/hold.instruction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:permission_handler/permission_handler.dart';

class StaggerPoseDetectorView extends StatefulWidget {
  const StaggerPoseDetectorView({super.key});

  @override
  State<StatefulWidget> createState() => _StaggerPoseDetectorViewState();
}

class _StaggerPoseDetectorViewState extends State<StaggerPoseDetectorView> {
  bool _canProcess = true;
  CustomPaint? _customPaint;
  bool _showGreat = false;
  bool _showWrong = false;
  bool _showRest = false;
  bool _isSpeaking = false;
  FlutterTts flutterTts = FlutterTts();
  final StaggerPoseMatcher _poseMatcher = StaggerPoseMatcher();

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

  void navigateToNextScreen() {
    if (_poseMatcher.reps == _poseMatcher.targetReps) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HoldInstructionScreen(),
        ),
      );
    }
  }

  Widget greatPosePain() => Positioned(
        top: 100,
        right: 20,
        left: 20,
        child: LayoutBuilder(
          builder: (context, constraints) {
            const text = "Great! Let's continue.";
            const textStyle = TextStyle(
              color: Color(0xff1B2C56),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            );

            final textPainter = TextPainter(
              text: const TextSpan(text: text, style: textStyle),
              textDirection: TextDirection.ltr,
              maxLines: 1,
            );

            textPainter.layout(maxWidth: constraints.maxWidth - 100);

            final isOverflown = textPainter.didExceedMaxLines;

            return Container(
              padding: const EdgeInsets.all(15),
              height: isOverflown ? null : 75,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xffEEF4F4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(children: [
                greatIcon,
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    text,
                    style: textStyle,
                  ),
                ),
              ]),
            );
          },
        ),
      );

  Widget wrongPosePain() => Positioned(
        top: 200,
        right: 20,
        left: 20,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // var text = widget.message;
            const text = "Wrong pose! Try again.";
            const textStyle = TextStyle(
              color: Color(0xff1B2C56),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            );

            final textPainter = TextPainter(
              text: TextSpan(text: text, style: textStyle),
              textDirection: TextDirection.ltr,
              maxLines: 1,
            );

            textPainter.layout(maxWidth: constraints.maxWidth - 100);

            final isOverflown = textPainter.didExceedMaxLines;

            return Container(
              padding: const EdgeInsets.all(15),
              height: isOverflown ? null : 75,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xffEEF4F4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(children: [
                wrongIcon,
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    text,
                    style: textStyle,
                  ),
                ),
              ]),
            );
          },
        ),
      );

  Widget overlayRestScreen() => Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: const SafeArea(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Căn giữa theo chiều dọc
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Căn giữa theo chiều ngang
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                      ),
                      child: Text('Raise your hands to start exercising'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  void showRestScreen() {
    if (_showRest) return;
    setState(() {
      _showRest = true;
    });
  }

  void showGreat() {
    if (_showGreat) return;
    setState(() {
      _showGreat = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showGreat = false;
        });
      }
    });
  }

  void showWrong() {
    if (_showWrong) return;
    setState(() {
      _showWrong = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showWrong = false;
        });
      }
    });
  }

  // function text to speech
  Future _speakMessage(message) async {
    if (!_isSpeaking) {
      setState(() {
        _isSpeaking = true;
      });
      await flutterTts.speak(message);
    }
  }

  @override
  void initState() {
    super.initState();
    flutterTts.setCompletionHandler(() {
      if (_isSpeaking) {
        setState(() {
          _isSpeaking = false;
        });
      }
    });
    _poseSubscription =
        poseChannel.receiveBroadcastStream().listen((dynamic event) {
      _poseData = PoseData.fromMap(event);

      if (!_poseData!.pose.allPoseLandmarksAreInFrame()) {
        _customPaint = null;
      } else {
        // if (_poseMatcher.isPoseInRestPosition(_poseData!.pose)) {
        //   showRestScreen();
        //   return;
        // }

        setState(() {
          _showRest = false;
        });

        Map<String, dynamic> poseDataStream =
            _poseMatcher.compareWithReferencePoses(_poseData!.pose);

        _updateCustomPaint(poseDataStream['errorLines']);
        navigateToNextScreen();

        if (poseDataStream['message'] != '') {
          _speakMessage(poseDataStream['message']);
        }

        if (poseDataStream['messageType'] == 'error') {
          showWrong();
        }
        // check poseDataStream['message'] == 1, 2, 3, 4, 5
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
      final painter = StaggerPosePainter(
          [_poseData!.pose],
          _poseData!.inputImageSize,
          InputImageRotation.rotation270deg,
          CameraLensDirection.front,
          errorLines);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
    }
  }

  // function text to speech
  Future _speakReps(number) async {
    FlutterTts flutterTts = FlutterTts();
    if (number == 1) {
      await flutterTts.speak("one");
    } else if (number == 2) {
      await flutterTts.speak("two");
    } else if (number == 3) {
      await flutterTts.speak("three");
    } else if (number == 4) {
      await flutterTts.speak("four");
    } else {
      await flutterTts.speak("five");
    }
  }

  Widget repsCountPane() => Positioned(
        bottom: 130,
        right: 80,
        left: 80,
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 120,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              '${_poseMatcher.reps} / ${_poseMatcher.targetReps}',
              style: const TextStyle(
                  color: Color(0xff1B2C56),
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
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
                    repsCountPane(),
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
            onPressed: () => Navigator.pop(context),
          ),
        ),
        if (_showGreat) greatPosePain(),
        // if (_showRest) overlayRestScreen(),
        if (_showWrong) wrongPosePain(),
      ],
    );
  }
}
