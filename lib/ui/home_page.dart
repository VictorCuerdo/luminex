import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:luminex/widgets/customslider.dart';

import '../controller/flashlight_controller.dart';
import '../widgets/altitude_tracker.dart';
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

  void _handleBezelPositionChange(double angleDifference) {
    if (angleDifference.abs() < 0.05) {
      setState(() {
        _bezelPosition = 0.0;
      });
      return;
    }

    setState(() {
      _bezelPosition = angleDifference;
      if (_controller.isOn) {
        if (angleDifference > 0) {
          _controller.startStrobe(
              milliseconds: (500 / math.pow(2, angleDifference)).toInt());
        } else if (angleDifference < 0) {
          _controller.startStrobe(
              milliseconds: (500 * math.pow(2, -angleDifference)).toInt());
        } else {
          _controller.stopStrobe();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
              children: <Widget>[
                const SizedBox(height: 30),
                CustomSlider(
                  value: _controller.intensity.clamp(0.0, 1.0),
                  onChanged: (value) {
                    setState(() {
                      _controller.setLightIntensity(value).then((_) {
                        setState(() {});
                      });
                    });
                  },
                ),
                const SizedBox(height: 20),
                /*RotativeBezel(
                  onPositionChange: _handleBezelPositionChange,
                  onRotation: (angleDifference) {},
                ),*/
                const HorizontalLines(),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OnButton(
                          controller: _controller,
                          onToggle: () {
                            setState(() {});
                          },
                        ).ignorePointer(_bezelPosition != 0.0),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 15,
            child: CompassWidget(),
          ),
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
