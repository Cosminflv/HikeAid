import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';

class BlocProviders {
  static AuthenticationViewBloc authentication(BuildContext context) =>
      BlocProvider.of<AuthenticationViewBloc>(context);
}
