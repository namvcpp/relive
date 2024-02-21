import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final double startYOffset;
  final double
      startXOffset; // Thêm tham số này để điều chỉnh vị trí bắt đầu theo chiều X

  DottedLinePainter({this.startYOffset = 0.0, this.startXOffset = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    double dashHeight = 8.0;
    double dashSpace = 4.0;
    double startY = startYOffset;
    double startX = startXOffset; // Sử dụng vị trí bắt đầu theo chiều X

    while (startY < size.height) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
