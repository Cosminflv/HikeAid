import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_state.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/user_profile/user_profile_view_bloc.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';

class AuthSessionBlocListener extends StatelessWidget {
  final Widget child;

  const AuthSessionBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthSessionBloc, AuthSessionState>(
            bloc: BlocProviders.authSession(context),
            listener: (context, state) {
              if (state is AuthSessionExistingState) {
                BlocProvider.of<UserProfileViewBloc>(context).add(FetchUserProfileEvent(state.session));
              }
            }),
      ],
      child: child,
    );
  }
}
