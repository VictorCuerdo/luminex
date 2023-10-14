// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassWidget extends StatefulWidget {
  final double width;
  final double height;
  final double arrowSize;

  const CompassWidget({
    Key? key,
    this.width = 100.0,
    this.height = 100.0,
    this.arrowSize = 20.0,
  }) : super(key: key);

  @override
  _CompassWidgetState createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  double _direction = 0.0;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events?.listen((event) {
      setState(() {
        _direction = event.heading ?? _direction;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -_direction * (pi / 180), // This will rotate the entire widget
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/compass.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Transform.rotate(
            angle: _direction *
                (pi /
                    180), // Reverse the rotation only for the arrow to keep it static pointing to North
            child: CustomPaint(
              painter: ArrowPainter(arrowSize: widget.arrowSize),
            ),
          ),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final double arrowSize;

  ArrowPainter({this.arrowSize = 25.0});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint arrowPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, -arrowSize)
      ..lineTo(arrowSize / 2, 0)
      ..lineTo(-arrowSize / 2, 0)
      ..close();

    canvas.drawPath(path, arrowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
