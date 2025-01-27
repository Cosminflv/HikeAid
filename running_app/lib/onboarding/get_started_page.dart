import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/bloc_listeners/auth_session_bloc_listener.dart';
import 'package:running_app/config/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_state.dart';

import 'package:running_app/shared_widgets/app_logo.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthSessionBlocListener(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Spacer to push the widget to the center
            const Spacer(),

            // Placeholder for the widget in the middle of the screen
            Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SizedBox.square(
                  dimension: MediaQuery.of(context).size.width / 2,
                  child: Container(color: Colors.transparent, child: const AppLogo()),
                ),
              ),
            ),

            // Spacer to maintain the middle widget position
            const Spacer(),

            // Get Started button at the bottom of the screen
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: BlocBuilder<AuthSessionBloc, AuthSessionState>(builder: (context, state) {
                  return CustomElevatedButton(
                      key: const ValueKey('GetStartedButton'),
                      backgroundColor: Theme.of(context).brightness == Brightness.light
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                      text: AppLocalizations.of(context)!.getStarted,
                      textColor: Theme.of(context).brightness == Brightness.light
                          ? Theme.of(context).colorScheme.onPrimary
                          : const Color.fromARGB(255, 44, 43, 50),
                      trailing: Icon(FontAwesomeIcons.arrowRight, color: Theme.of(context).colorScheme.surface),
                      onTap: () {
                        if (state is AuthSessionExistingState) {
                          Navigator.of(context).pushReplacementNamed(RouteNames.homePage);
                        } else {
                          Navigator.of(context).pushNamed(RouteNames.authenticationPage);
                        }
                      });
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
