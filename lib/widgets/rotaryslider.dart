// ignore_for_file: library_private_types_in_public_api, prefer_const_declarations

import 'dart:math';

import 'package:flutter/material.dart';

class RotarySlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const RotarySlider({super.key, required this.value, required this.onChanged});

  @override
  _RotarySliderState createState() => _RotarySliderState();
}

class _RotarySliderState extends State<RotarySlider> {
  double _currentAngle = 0;

  @override
  void initState() {
    super.initState();
    _currentAngle = widget.value;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final touchPosition = details.localPosition;
    final center = const Offset(50, 50); // Assuming size is 100x100
    final angle =
        atan2(touchPosition.dy - center.dy, touchPosition.dx - center.dx);

    setState(() {
      _currentAngle = angle;
      widget.onChanged(_currentAngle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      child: CustomPaint(
        size: const Size(100, 100),
        painter: _RotaryPainter(_currentAngle),
      ),
    );
  }
}

class _RotaryPainter extends CustomPainter {
  final double angle;

  _RotaryPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    // Paint the background
    canvas.drawCircle(center, size.width / 2, paint);

    // Rotate canvas for the knob
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);

    // Paint the knob
    final knobPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(0, 0), 15, knobPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
