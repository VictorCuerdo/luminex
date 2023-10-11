import 'package:flutter/material.dart';

import '../controller/flashlight_controller.dart';
import '../widgets/customslider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlashlightController _controller = FlashlightController();
  double _bezelPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E3E3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Rotative Bezel
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _bezelPosition += details.primaryDelta!;
                // Update strobe speed or other functionalities based on _bezelPosition here if needed
              });
            },
            child: Container(
              height: 100.0, // Height of the bezel
              color: Colors.grey[800],
              width: double.infinity,
              child: CustomPaint(
                painter: CylinderPainter(_bezelPosition),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      await _controller.toggleLight();
                      setState(() {}); // to trigger a rebuild
                    },
                    child: _controller.isOn
                        ? Image.asset('assets/on.png', width: 160, height: 160)
                        : Image.asset('assets/off.png',
                            width: 160, height: 160),
                  ),
                  const SizedBox(height: 70),
                  CustomSlider(
                    value: _controller.intensity,
                    onChanged: (value) {
                      setState(() {
                        _controller.setLightIntensity(value);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CylinderPainter extends CustomPainter {
  final double position;
  final int cylinderCount = 9; // Number of cylinders
  final double cylinderWidth = 30.0; // Width of each cylinder
  final double cylinderHeight = 60.0; // Height of each cylinder
  final double space = 10.0; // Space between each cylinder

  CylinderPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;

    double singleSetWidth = (cylinderCount * (cylinderWidth + space)) -
        space; // Total width for one set of cylinders
    double startPosition = position % singleSetWidth;

    for (int i = 0; true; i++) {
      // Infinite loop, but we'll break out of it conditionally
      double offset = (i * (cylinderWidth + space)) - startPosition;

      // If a cylinder is off the screen to the right, break out of loop.
      if (offset > width) break;

      final Rect rect = Rect.fromLTWH(offset,
          (size.height - cylinderHeight) / 2, cylinderWidth, cylinderHeight);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
            rect,
            const Radius.circular(
                15)), // Adjust the radius for more oval appearance
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
