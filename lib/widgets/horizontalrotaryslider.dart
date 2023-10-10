// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class HorizontalRotarySlider extends StatefulWidget {
  final double value; // between 0 and 1
  final Function(double) onChanged;

  const HorizontalRotarySlider(
      {super.key, required this.value, required this.onChanged});

  @override
  _HorizontalRotarySliderState createState() => _HorizontalRotarySliderState();
}

class _HorizontalRotarySliderState extends State<HorizontalRotarySlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _currentValue +=
              details.primaryDelta! / MediaQuery.of(context).size.width;
          _currentValue = _currentValue.clamp(0.0, 1.0);
          widget.onChanged(_currentValue);
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100, // or whatever height you want for the slider
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Center(
          child: Transform.translate(
            offset: Offset(
                (_currentValue - 0.5) * MediaQuery.of(context).size.width, 0),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
