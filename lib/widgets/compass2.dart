// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:vector_math/vector_math.dart' show radians;

class Compass2 extends StatefulWidget {
  final double size;

  const Compass2({super.key, required this.size});

  @override
  _Compass2State createState() => _Compass2State();
}

class _Compass2State extends State<Compass2> {
  double? _direction = 0.0; // Initialize with 0.0 (or null, if you prefer).

  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen(_onData);
  }

  void _onData(CompassEvent event) => setState(() {
        _direction = event.heading!;
      });

  @override
  void dispose() {
    FlutterCompass.events!.listen(_onData).cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if _direction is not null before building the compass.
    return Transform.rotate(
      angle: radians(-_direction!),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Icon(
          Icons.navigation,
          color: Colors.white,
          size: widget.size * 0.5,
        ),
      ),
    );
  }
}
