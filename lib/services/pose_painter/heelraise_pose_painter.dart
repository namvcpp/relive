import 'package:camera/camera.dart';
import 'package:fit_worker/services/pose_detector.dart';
import 'package:fit_worker/services/pose_painter/pose_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import '../coordinates_translator.dart';
import '../pose_matcher/utils.dart';
import 'dart:math' as math;

class HeelRaisePosePainter extends PosePainter {
  HeelRaisePosePainter(
    List<Pose> poses,
    Size imageSize,
    InputImageRotation rotation,
    CameraLensDirection cameraLensDirection,
    this.isMatched,
  ) : super(poses, imageSize, rotation, cameraLensDirection, []);

  final bool isMatched;

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

    final correctPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..color = Colors.green;

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
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftFootIndex, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightFootIndex,
          rightPaint);

      //Draw legs
      paintLine(PoseLandmarkType.leftFootIndex, PoseLandmarkType.leftKnee, leftPaint);
      paintLine(
          PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
      paintLine(
          PoseLandmarkType.rightFootIndex, PoseLandmarkType.rightKnee, rightPaint);
      paintLine(
          PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);

      if (isMatched) {
        paintLine(PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle,
            correctPaint);
        paintLine(
            PoseLandmarkType.leftAnkle, PoseLandmarkType.leftFootIndex, correctPaint);
        paintLine(PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle,
            correctPaint);
        paintLine(PoseLandmarkType.rightAnkle, PoseLandmarkType.rightFootIndex,
            correctPaint);
      }

      Offset _getVector(PoseLandmark start, PoseLandmark end) {
        return Offset(end.x - start.x, end.y - start.y);
      }

      double _calculateVectorsAngle(Offset v1, Offset v2) {
        final dotProduct = v1.dx * v2.dx + v1.dy * v2.dy;
        final magnitudeV1 = math.sqrt(v1.dx * v1.dx + v1.dy * v1.dy);
        final magnitudeV2 = math.sqrt(v2.dx * v2.dx + v2.dy * v2.dy);
        final angle = math.acos(dotProduct / (magnitudeV1 * magnitudeV2));
        return angle;
      }

      Offset _pointOnVector(Offset vector, Offset startPoint, double distance) {
        final direction = vector / vector.distance;
        return startPoint + direction * distance;
      }

      void _drawAngleCurve(
          Canvas canvas,
          PoseLandmarkType centerType,
          PoseLandmarkType startType,
          PoseLandmarkType endType,
          Paint paint,
          Size size,
          Size imageSize,
          InputImageRotation rotation,
          CameraLensDirection cameraLensDirection,
      ) {
        PoseLandmark center = poses.first.landmarks[centerType]!;
        PoseLandmark start = poses.first.landmarks[startType]!;
        PoseLandmark end = poses.first.landmarks[endType]!;
        
        // Calculate vectors
        Offset centerToStartVector = _getVector(center, start);
        Offset centerToEndVector = _getVector(center, end);

        // Calculate the angle between the two vectors
        double angle = _calculateVectorsAngle(centerToStartVector, centerToEndVector);

        // Calculate points on vectors
        double arcDistance = 20.0; // Distance from center to arc's points
        Offset point1 = _pointOnVector(centerToStartVector, Offset(center.x, center.y), arcDistance);
        Offset point2 = _pointOnVector(centerToEndVector, Offset(center.x, center.y), arcDistance);

        // Convert points to canvas coordinates
        point1 = Offset(
          translateX(point1.dx, size, imageSize, rotation, cameraLensDirection),
          translateY(point1.dy, size, imageSize, rotation, cameraLensDirection),
        );
        point2 = Offset(
          translateX(point2.dx, size, imageSize, rotation, cameraLensDirection),
          translateY(point2.dy, size, imageSize, rotation, cameraLensDirection),
        );

        // Determine the rect in which the arc is drawn
        final Rect rect = Rect.fromCircle(center: point1, radius: arcDistance);

        // Determine the show angle
        final showAngle = math.atan2(point2.dy - point1.dy, point2.dx - point1.dx);

        // Draw the arc
        canvas.drawArc(rect, showAngle, angle, false, paint);
      }

      final anglePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

      _drawAngleCurve(
        canvas,
        PoseLandmarkType.leftShoulder,
        PoseLandmarkType.leftElbow,
        PoseLandmarkType.leftHip,
        anglePaint,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
    }
  }

  @override
  bool shouldRepaint(covariant HeelRaisePosePainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.poses != poses;
  }
}
