import 'package:core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/location/location_event.dart';

class RunningApp extends StatefulWidget {
  const RunningApp({super.key});

  @override
  State<RunningApp> createState() => _RunningAppState();
}

class _RunningAppState extends State<RunningApp> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && sl.isRegistered<LocationBloc>()) {
      sl.get<LocationBloc>().add(AppResumedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
