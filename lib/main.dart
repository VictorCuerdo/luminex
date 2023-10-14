// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

import 'ui/loading_screen.dart';

final TorchController torchController = TorchController();

void main() {
  torchController.initialize();
  runApp(LuminexApp());
}

class LuminexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luminex',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoadingScreen(),
    );
  }
}
