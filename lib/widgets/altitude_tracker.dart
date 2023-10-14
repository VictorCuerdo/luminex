// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class AltitudeTracker extends StatefulWidget {
  final double size;

  const AltitudeTracker({super.key, this.size = 100.0});

  @override
  _AltitudeTrackerState createState() => _AltitudeTrackerState();
}

class _AltitudeTrackerState extends State<AltitudeTracker> {
  double? _altitude;
  final Location location = Location();

  @override
  void initState() {
    super.initState();
    _fetchAltitude();
  }

  _fetchAltitude() async {
    try {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      final data = await location.getLocation();
      setState(() {
        _altitude = data.altitude;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Center(
            child: _altitude == null
                ? const CircularProgressIndicator()
                : Text(
                    'Altitude: ${_altitude!.toStringAsFixed(2)} m',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: widget.size * 0.15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }
}
