import 'package:domain/entities/auth_session_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_state.dart';

AuthSessionEntity? getSession(BuildContext context) {
  final state = BlocProvider.of<AuthSessionBloc>(context).state;

  if (state is! AuthSessionExistingState) {
    return null;
  }

  return state.session;
}
