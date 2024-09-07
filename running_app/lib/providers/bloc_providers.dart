import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';

class BlocProviders {
  static AuthenticationViewBloc authentication(BuildContext context) =>
      BlocProvider.of<AuthenticationViewBloc>(context);

  static RegistrationViewBloc registration(BuildContext context) => BlocProvider.of<RegistrationViewBloc>(context);
}
