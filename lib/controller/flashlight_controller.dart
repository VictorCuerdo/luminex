import 'dart:async';

import 'package:torch_controller/torch_controller.dart';

class FlashlightController {
  final TorchController _torchController = TorchController();

  bool _isOn = false;
  double _intensity = 1.0; // default to 1.0 for full intensity

  Future<bool> toggleLight() async {
    bool? result = await _torchController.toggle(intensity: _intensity);
    _isOn = result ?? false;
    return _isOn;
  }

  Future<void> setLightIntensity(double intensity) async {
    if (intensity >= 0.0 && intensity <= 1.0) {
      _intensity = intensity;
      if (_isOn) {
        // Only update intensity if the torch is active
        await _torchController.toggle(intensity: _intensity);
      }
    }
  }

  bool get isOn => _isOn;
  double get intensity => _intensity;

  Timer? _strobeTimer;
  // Call this method to start the strobe effect.
  Future<void> startStrobe({required int milliseconds}) async {
    stopStrobe(); // Ensure we don't have multiple timers running simultaneously.
    _strobeTimer =
        Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      toggleLight();
    });
  }

  // Call this method to stop the strobe effect.
  void stopStrobe() {
    _strobeTimer?.cancel();
    _strobeTimer = null;
  }
}
