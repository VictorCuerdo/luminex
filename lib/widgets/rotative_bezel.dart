// ignore_for_file: library_private_types_in_public_api

import 'dart:math' as math;

import 'package:flutter/material.dart';

class BezelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    final Paint bezelPaint = Paint()
      ..color = Colors.grey[800]!
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, bezelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RotativeBezel extends StatefulWidget {
  final ValueChanged<double> onRotation;

  const RotativeBezel(
      {super.key,
      required this.onRotation,
      required Null Function(dynamic position) onPositionChange});

  @override
  _RotativeBezelState createState() => _RotativeBezelState();
}

class _RotativeBezelState extends State<RotativeBezel> {
  Offset? _lastRotation;

  double _calculateAngle(Offset first, Offset second) {
    return (math.atan2(second.dy, second.dx) - math.atan2(first.dy, first.dx))
        .clamp(-1.0, 1.0);
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_lastRotation == null) {
      _lastRotation = details.localPosition;
      return;
    }

    final angleDifference =
        _calculateAngle(_lastRotation!, details.localPosition);
    widget.onRotation(angleDifference);

    _lastRotation = details.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      onPanEnd: (_) {
        _lastRotation = null;
      },
      child: CustomPaint(
        painter: BezelPainter(),
        size: const Size(200, 200),
      ),
    );
  }
}
