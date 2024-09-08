import 'package:core/di/injection_container.dart';
import 'package:core/config.dart';
import 'package:flutter/material.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/running_app.dart';
import 'package:gem_kit/core.dart';

Future<void> main() async {
  initEarlyDependencies();
  await GemKit.initialize(appAuthorization: gemApiToken)
      .then((value) => sl.get<AppBloc>().add(UpdateAppStatusEvent(AppStatus.intializedSDK)));

  runApp(const RunningApp());
}
