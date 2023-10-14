// lines.dart

// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class SideLines extends StatelessWidget {
  const SideLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 95,
          top: 100,
          bottom: 300,
          child: Container(
            width: 3,
            color: Colors.black45,
          ),
        ),
        Positioned(
          right: 95,
          top: 100,
          bottom: 300,
          child: Container(
            width: 3,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }
}

class HorizontalLines extends StatelessWidget {
  const HorizontalLines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.0, // thickness of the line
      width: 500.0, // adjustable width of the line
      color: const Color(0xFFF2F2F2),
    );
  }
}
