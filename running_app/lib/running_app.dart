import 'package:core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/location/location_event.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/get_started_page.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl.get<AuthenticationViewBloc>()),
        BlocProvider(create: (context) => sl.get<RegistrationViewBloc>()),
        BlocProvider(create: (context) => sl.get<LocationBloc>()),
        BlocProvider(create: (context) => sl.get<AppBloc>()),
      ],
      child: MaterialApp(
        title: "Running App",
        theme: (MediaQuery.of(context).platformBrightness == Brightness.light) ? lightThemeData : darkThemeData,
        home: const GetStartedPage(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('es', ''),
          Locale('de', ''),
          Locale('fr', ''),
        ],
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
