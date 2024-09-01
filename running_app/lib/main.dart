import 'package:core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:running_app/running_app.dart';

void main() {
  initEarlyDependencies();
  runApp(const RunningApp());
}
