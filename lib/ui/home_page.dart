// ignore_for_file: library_private_types_in_public_api
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../controller/flashlight_controller.dart';
import '../widgets/altitude_tracker.dart';
import '../widgets/bezel_painter.dart'; // Ensure this import is added for RotativeBezel
import '../widgets/compass.dart';
import '../widgets/lines.dart';
import '../widgets/on_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlashlightController _controller = FlashlightController();
  double _bezelPosition = 0.0;
  Color _startColor = const Color(0xFF838383);
  Color _endColor = const Color(0xFF3B3638);

  void _changeGradientStartColor() async {
    Color? pickedColor = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pick a color"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _startColor,
              onColorChanged: (Color newColor) => setState(() {
                _startColor = newColor;
              }),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (pickedColor != null) {
      setState(() {
        _startColor = pickedColor;
      });
    }
  }

  void _changeGradientEndColor() async {
    Color? pickedColor = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pick a background color"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _endColor,
              onColorChanged: (Color newColor) => setState(() {
                _endColor = newColor;
              }),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (pickedColor != null) {
      setState(() {
        _endColor = pickedColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.5,
                colors: [
                  _startColor,
                  _endColor,
                ],
                stops: const [0, 1],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RotativeBezel(
                  onPositionChange: (position) {
                    setState(() {
                      _bezelPosition = position;
                      if (_controller.isOn) {
                        if (position > 0) {
                          _controller.startStrobe(
                              milliseconds:
                                  (500 / math.pow(2, position)).toInt());
                        } else if (position < 0) {
                          _controller.startStrobe(
                              milliseconds:
                                  (500 * math.pow(2, -position)).toInt());
                        } else {
                          _controller.stopStrobe();
                        }
                      }
                    });
                  },
                ),
                const HorizontalLines(),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OnButton(
                          controller: _controller,
                          onToggle: () {
                            setState(() {});
                          },
                        ).ignorePointer(_bezelPosition != 0.0),
                        const SizedBox(height: 70),
                        /* CustomSlider(
                          value: _controller.intensity.clamp(0.0, 1.0),
                          onChanged: (value) {
                            setState(() {
                              _controller.setLightIntensity(value).then((_) {
                                setState(() {});
                              });
                            });
                          },
                        ),
                        CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 50),
                          painter: SemiCirclePainter(),
                        ), */
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //const SideLines(),
          const Positioned(
            bottom: 0,
            left: 15,
            child: CompassWidget(),
          ),
          /*const Positioned(
            bottom: 0,
            left: 15,
            child: Compass2(size: 150.0),
          ),*/
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: AltitudeTracker(size: 50.0),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF3C5DD6),
              onPressed: () {
                _changeGradientStartColor();
                _changeGradientEndColor();
              },
              child: const Icon(Icons.palette),
            ),
          ),
        ],
      ),
    );
  }
}

extension CustomIgnorePointer on Widget {
  Widget ignorePointer(bool ignore) {
    return IgnorePointer(
      ignoring: ignore,
      child: this,
    );
  }
}
