import 'package:core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_state.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/user_profile/user_profile_view_bloc.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';
import 'package:running_app/utils/toasts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthSessionBlocListener extends StatelessWidget {
  final Widget child;

  const AuthSessionBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProviders.app(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthSessionBloc, AuthSessionState>(
          listener: (context, state) {
            appBloc.add(UpdateAppStatusEvent(AppStatus.intializedSDK));
          },
          listenWhen: (prev, curr) => prev is AuthSessionExistingState && curr is AuthSessionNotExistingState,
        ),
        BlocListener<AuthSessionBloc, AuthSessionState>(
          bloc: BlocProviders.authSession(context),
          listener: (context, state) {
            if (state is AuthSessionExistingState) {
              //Navigator.of(context).pushReplacementNamed(RouteNames.homePage);
              BlocProvider.of<UserProfileViewBloc>(context).add(FetchUserProfileEvent(state.session));
            }
            if (state is AuthSessionNotExistingState) {
              Navigator.of(context).pushReplacementNamed(RouteNames.getStartedPage);
              discardBlocsIfRegistered();
            }
            if (state is AuthSessionFailureState) {
              showErrorToast(AppLocalizations.of(context)!.logoutFail);
            }
          },
          listenWhen: (previous, current) =>
              (previous is AuthSessionNotExistingState && current is AuthSessionExistingState) ||
              (previous is AuthSessionExistingState && current is AuthSessionNotExistingState),
        ),
      ],
      child: child,
    );
  }
}
