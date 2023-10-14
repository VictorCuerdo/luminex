// on_button.dart

import 'package:flutter/material.dart';

import '../controller/flashlight_controller.dart';
import 'oval_painter.dart';

class OnButton extends StatelessWidget {
  final FlashlightController controller;
  final VoidCallback onToggle;

  const OnButton({
    Key? key,
    required this.controller,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await controller.toggleLight();
        onToggle(); // Call the provided callback
        if (!controller.isOn) {
          controller.stopStrobe(); // Stop the strobe effect
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(160, 160), // Match the size of the image
            painter: OvalPainter(),
          ),
          controller.isOn
              ? Image.asset('assets/on.png', width: 160, height: 160)
              : Image.asset('assets/off.png', width: 160, height: 160),
        ],
      ),
    );
  }
}
