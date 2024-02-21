import 'package:camera/camera.dart';
import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_painter/pose_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import '../coordinates_translator.dart';

class StaggerPosePainter extends PosePainter {
  StaggerPosePainter(
    List<Pose> poses,
    Size imageSize,
    InputImageRotation rotation,
    CameraLensDirection cameraLensDirection,
    List<List<PoseLandmarkType>>? errorLines,
  ) : super(
          poses,
          imageSize,
          rotation,
          cameraLensDirection,
          errorLines,
        );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..color = Colors.white;

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = Colors.white;

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = Colors.white;

    final errorPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..color = Colors.red;

    final correctPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..color = Colors.green;

    final Paint legPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = Colors.yellow;

    for (final pose in poses) {
      pose.landmarks.forEach(
        (_, landmark) {
          canvas.drawCircle(
              Offset(
                translateX(
                  landmark.x,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  landmark.y,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
              ),
              1,
              paint);
        },
      );

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
            Offset(
                translateX(
                  joint1.x,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  joint1.y,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                )),
            Offset(
                translateX(
                  joint2.x,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  joint2.y,
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                )),
            paintType);
      }

      //Draw arms
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, leftPaint);
      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          rightPaint);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, rightPaint);

      //Draw Body
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
          rightPaint);

      //Draw legs
      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, legPaint);
      paintLine(
          PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, legPaint);
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, legPaint);
      paintLine(
          PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, legPaint);

      if (errorLines!.isNotEmpty) {
        for (final errorLine in errorLines!) {
          if (errorLine[0] == PoseLandmarkType.leftKnee) {
            paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee,
                correctPaint);
            paintLine(PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle,
                correctPaint);
            continue;
          }

          if (errorLine[0] == PoseLandmarkType.rightKnee) {
            paintLine(PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee,
                correctPaint);
            paintLine(PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle,
                correctPaint);
            continue;
          }

          paintLine(errorLine[0], errorLine[1], errorPaint);
        }
      }
    }
  }
}
