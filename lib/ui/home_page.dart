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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.5,
                colors: [
                  Color(0xFF838383),
                  Color(0xFF3B3638),
                ],
                stops: [0, 1],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Rotative Bezel
                GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _bezelPosition -= details.primaryDelta!;
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
                ),
                // Horizontal Line with adjustable width
                Container(
                  height: 5.0, // thickness of the line
                  width: 500.0, // adjustable width of the line
                  color: Color(0xFFF2F2F2),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await _controller.toggleLight();
                            setState(() {});
                          },
                          child: _controller.isOn
                              ? Image.asset('assets/on.png',
                                  width: 160, height: 160)
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
                        // Space for the semicircle
                        CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 50),
                          painter: SemiCirclePainter(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 100,
            top: 100,
            bottom: 215,
            child: Container(
              width: 3,
              color: Colors.black45,
            ),
          ),
          Positioned(
            right: 100,
            top: 100,
            bottom: 215,
            child: Container(
              width: 3,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}

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
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

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
