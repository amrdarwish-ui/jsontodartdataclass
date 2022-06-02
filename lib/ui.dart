import 'package:dims_config/dims_config.dart';
import 'package:flutter/material.dart';
import 'package:json_to_dataclass/ui_mobile.dart';
import 'package:json_to_dataclass/ui_pc.dart';

class Ui extends StatefulWidget {
  Ui({Key? key}) : super(key: key);

  @override
  State<Ui> createState() => _UiState();
}

class _UiState extends State<Ui> {
  @override
  Widget build(BuildContext context) {
    return MultiDevice(mobile: UiMobile(), computer: UiPc());
  }
}
