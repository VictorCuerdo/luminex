// oval_painter.dart

import 'package:flutter/material.dart';

class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFF2F2F2)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double width = size.width * 2; // 85% of the button's width
    final double height = size.height * 2; // 110% of the button's height

    canvas.drawOval(
        Rect.fromCenter(center: center, width: width, height: height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
