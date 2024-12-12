import 'package:core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:running_app/running_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initEarlyDependencies();
  // await GemKit.initialize(appAuthorization: gemApiToken)
  //     .then((value) => sl.get<AppBloc>().add(UpdateAppStatusEvent(AppStatus.intializedSDK)));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const RunningApp());
}
