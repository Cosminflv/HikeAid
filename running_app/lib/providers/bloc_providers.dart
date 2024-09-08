import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';

class BlocProviders {
  static AuthenticationViewBloc authentication(BuildContext context) =>
      BlocProvider.of<AuthenticationViewBloc>(context);

  static RegistrationViewBloc registration(BuildContext context) => BlocProvider.of<RegistrationViewBloc>(context);

  static MapViewBloc map(BuildContext context) => BlocProvider.of<MapViewBloc>(context);
  static AppBloc app(BuildContext context) => BlocProvider.of<AppBloc>(context);
}
