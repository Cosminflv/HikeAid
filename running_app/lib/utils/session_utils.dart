import 'package:domain/entities/auth_session_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_state.dart';

AuthSessionEntity? getSession(BuildContext context) {
  final state = BlocProvider.of<AuthenticationViewBloc>(context).state;

  if (state is! AuthenticationSuccesfulState) {
    return null;
  }

  return state.session;
}
