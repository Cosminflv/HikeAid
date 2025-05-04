import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/bloc_listeners/auth_session_bloc_listener.dart';
import 'package:running_app/config/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_state.dart';

import 'package:running_app/shared_widgets/custom_text_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthSessionBlocListener(
      child: Scaffold(
        // If you ever add an AppBar and want the image behind it:
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 39.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // decorate the container with your background image
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/home_page_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              // your existing layout goes here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: BlocBuilder<AuthSessionBloc, AuthSessionState>(
                        builder: (context, state) {
                          return CustomElevatedButton(
                            key: const ValueKey('GetStartedButton'),
                            backgroundColor: Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurface,
                            text: AppLocalizations.of(context)!.getStarted,
                            textColor: Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).colorScheme.onPrimary
                                : const Color.fromARGB(255, 44, 43, 50),
                            trailing: Icon(
                              FontAwesomeIcons.arrowRight,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            onTap: () {
                              if (state is AuthSessionExistingState) {
                                Navigator.of(context).pushReplacementNamed(RouteNames.homePage);
                              } else {
                                Navigator.of(context).pushNamed(RouteNames.authenticationPage);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
