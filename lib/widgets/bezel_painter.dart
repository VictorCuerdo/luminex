// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../widgets/cylinder.dart'; // Make sure the path is correct

class RotativeBezel extends StatefulWidget {
  final ValueChanged<double> onPositionChange;

  const RotativeBezel(
      {Key? key,
      required this.onPositionChange,
      required Null Function(dynamic angleDifference) onRotation})
      : super(key: key);

  @override
  _RotativeBezelState createState() => _RotativeBezelState();
}

class _RotativeBezelState extends State<RotativeBezel> {
  double _bezelPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _bezelPosition -= details.primaryDelta!;
          widget.onPositionChange(_bezelPosition);
        });
      },
      child: Container(
        height: 100.0,
        width: double.infinity,
        color: Colors.black,
        child: CustomPaint(
          painter: CylinderPainter(_bezelPosition),
        ),
      ),
    );
  }
}
