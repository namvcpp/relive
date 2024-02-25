import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_painter/pose_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import '../coordinates_translator.dart';
import '../pose_matcher/utils.dart';
import 'dart:math' as math;

class SquatPosePainter extends PosePainter {
  SquatPosePainter(
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
      ..strokeWidth = 8.0
      ..color = Colors.white;

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = Colors.white;

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = Colors.white;

    final errorPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = Colors.red;

    final correctPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = Colors.green;

    final Paint legPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = Colors.yellow;

    // final Paint anglePaint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 8.0
    //   ..color = Colors.blue;

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

      void drawArc(
          PoseLandmarkType centerType,
          PoseLandmarkType startType,
          PoseLandmarkType endType,
          Paint paintType,
          Size size,
          Size imageSize,
          InputImageRotation rotation,
          CameraLensDirection cameraLensDirection) {
        final PoseLandmark joint1 = pose.landmarks[centerType]!;
        final PoseLandmark joint2 = pose.landmarks[startType]!;
        final PoseLandmark joint3 = pose.landmarks[endType]!;

        print('Angle: ${angleCalculate(joint1, joint2, joint3)}');

        if (angleCalculate(joint1, joint2, joint3) < 80 ||
            angleCalculate(joint1, joint2, joint3) > 120) {
          return;
        }

        final Offset center = Offset(
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
          ),
        );

        final Offset start = Offset(
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
          ),
        );

        final Offset end = Offset(
          translateX(
            joint3.x,
            size,
            imageSize,
            rotation,
            cameraLensDirection,
          ),
          translateY(
            joint3.y,
            size,
            imageSize,
            rotation,
            cameraLensDirection,
          ),
        );

        double startAngle = math.atan2(
          center.dy - start.dy,
          center.dx - start.dx,
        );
        if (startAngle < 0) {
          startAngle += 2 * math.pi;
        }
        startAngle = math.pi + startAngle;
        if (startAngle > 2 * math.pi) {
          startAngle -= 2 * math.pi;
        }

        double endAngle = math.atan2(
          center.dy - end.dy,
          center.dx - end.dx,
        );
        if (endAngle < 0) {
          endAngle += 2 * math.pi;
        }

        double sweepAngle = endAngle + (math.pi - startAngle);

        double radius = 50 * ((sweepAngle * 180 / math.pi) / 90);

        final Rect rect = Rect.fromCircle(center: center, radius: radius);

        canvas.drawArc(rect, startAngle, sweepAngle, true, paintType);
        // canvas print sweepAngle value near the arc
        final textAngle = TextPainter(
          text: TextSpan(
            text: (sweepAngle * 180 / math.pi).toStringAsFixed(0),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        // Tính toán trung điểm của cung tròn
        double midX =
            (radius * math.cos(startAngle + sweepAngle / 2) + center.dx - 25);
        double midY =
            (radius * math.sin(startAngle + sweepAngle / 2) + center.dy - 25);

        Offset labelPosition = Offset(
          midX,
          midY,
        );
        textAngle.layout();
        textAngle.paint(canvas, labelPosition);
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

      //Draw Arc
      // drawArc(
      //     PoseLandmarkType.leftShoulder,
      //     PoseLandmarkType.leftElbow, // start
      //     PoseLandmarkType.leftHip, // end
      //     correctPaint,
      //     size,
      //     imageSize,
      //     rotation,
      //     cameraLensDirection);

      // drawArc(
      //     PoseLandmarkType.rightShoulder,
      //     PoseLandmarkType.rightHip, // start
      //     PoseLandmarkType.rightElbow, // end
      //     correctPaint,
      //     size,
      //     imageSize,
      //     rotation,
      //     cameraLensDirection);

      // drawArc(
      //   PoseLandmarkType.leftKnee,
      //   PoseLandmarkType.leftHip,
      //   PoseLandmarkType.leftAnkle,
      //   correctPaint,
      //   size,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );

      // drawArc(
      //   PoseLandmarkType.rightKnee,
      //   PoseLandmarkType.rightAnkle,
      //   PoseLandmarkType.rightHip,
      //   correctPaint,
      //   size,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );

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
          // Check if line in this [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
          // [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
          // [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
          // [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle]
          if (errorLine[0] == PoseLandmarkType.leftHip ||
              errorLine[0] == PoseLandmarkType.leftKnee ||
              errorLine[0] == PoseLandmarkType.rightHip ||
              errorLine[0] == PoseLandmarkType.rightKnee) {
            paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee,
                correctPaint);
            paintLine(PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle,
                correctPaint);
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
