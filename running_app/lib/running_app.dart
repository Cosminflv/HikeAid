import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:running_app/alerts/alert_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_bloc.dart';
import 'package:running_app/friendships/friendships_view_bloc.dart';
import 'package:running_app/internet_connection/internet_connection_events.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/location/location_event.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/map_styles/map_styles_panel_events.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_events.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/get_started_page.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/search/search_menu_bloc.dart';
import 'package:running_app/search_users/search_users_view_bloc.dart';
import 'package:running_app/user_profile/user_profile_view_bloc.dart';

class RunningApp extends StatefulWidget {
  const RunningApp({super.key});

  @override
  State<RunningApp> createState() => _RunningAppState();
}

class _RunningAppState extends State<RunningApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    //initBlocs();

    AppBlocs.mapStylesBloc.add(InitLocalMapStylesEvent(null));
    sl.get<AuthSessionBloc>().add(CheckForSessionEvent());
  }

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
        BlocProvider(create: (context) => sl.get<AuthSessionBloc>()),
        BlocProvider(create: (context) => sl.get<FriendshipsViewBloc>()),
        BlocProvider(create: (context) => sl.get<AuthenticationViewBloc>()),
        BlocProvider(create: (context) => sl.get<RegistrationViewBloc>()),
        BlocProvider(create: (context) => sl.get<LocationBloc>()),
        BlocProvider(create: (context) => sl.get<UserProfileBloc>()),
        BlocProvider(create: (context) => sl.get<AppBloc>()),
        BlocProvider(create: (context) => sl.get<AlertBloc>()),
        BlocProvider(create: (context) => sl.get<SearchUsersBloc>()),
        BlocProvider(create: (context) => sl.get<SearchMenuBloc>()),
        BlocProvider(create: (context) => AppBlocs.internetConnectionBloc..add(CheckInternetConnectionEvent())),
        BlocProvider(create: (context) => AppBlocs.tourRecordingBloc),
        BlocProvider(create: (context) => sl.get<EditUserProfileViewBloc>())
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
