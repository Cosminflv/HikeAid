import 'package:core/di/injection_container.dart';
import 'package:core/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/running_app.dart';
import 'package:gem_kit/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initEarlyDependencies(ipv4Address);
  await GemKit.initialize(appAuthorization: gemApiToken)
      .then((value) => sl.get<AppBloc>().add(UpdateAppStatusEvent(AppStatus.intializedSDK)));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const RunningApp());
}
