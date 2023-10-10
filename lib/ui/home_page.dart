// ignore_for_file: library_private_types_in_public_api
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 50, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () async {
                await _controller.toggleLight();
                print("Flashlight isOn: ${_controller.isOn}");
                setState(() {}); // to trigger a rebuild
              },
              child: _controller.isOn
                  ? Image.asset('assets/on.png', width: 160, height: 160)
                  : Image.asset('assets/off.png', width: 160, height: 160),
            ),
            const SizedBox(height: 70),
            // Use the RotarySlider instead of the regular Slider
            CustomSlider(
              value: _controller.intensity,
              onChanged: (value) {
                setState(() {
                  _controller.setLightIntensity(value);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
