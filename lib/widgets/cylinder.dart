// cylinder.dart

import 'package:flutter/material.dart';

class CylinderPainter extends CustomPainter {
  final double position;
  final int cylinderCount = 9;
  final double cylinderWidth = 20.0;
  final double cylinderHeight = 60.0;
  final double space = 10.0;

  CylinderPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;

    double singleSetWidth = (cylinderCount * (cylinderWidth + space)) - space;
    double startPosition = position % singleSetWidth;

    for (int i = 0; true; i++) {
      double offset = (i * (cylinderWidth + space)) - startPosition;

      if (offset > width) break;

      final Rect rect = Rect.fromLTWH(offset,
          (size.height - cylinderHeight) / 2, cylinderWidth, cylinderHeight);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect,
          const Radius.circular(15),
        ),
        Paint()
          ..color = const Color(0xFF696969)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black45
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final double width = size.width - 200;

    canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, 0), radius: width / 2),
        0,
        3.14159,
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
