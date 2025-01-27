import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/bloc_listeners/auth_session_bloc_listener.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/onboarding/auth_session/auth_session_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_events.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_event.dart';
import 'package:running_app/onboarding/authentication/authentication_view_state.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';
import 'package:running_app/utils/converters.dart';
import 'package:running_app/utils/debouncer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final Debouncer debouncer = Debouncer(milliseconds: Durations.long1.inMilliseconds);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    AppBlocs.authenticationViewBloc.add(AuthClearEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthSessionBlocListener(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.welcome,
                style: Theme.of(context).textTheme.displayMedium,
              ),

              const SizedBox(
                height: 15,
              ),

              Text(
                AppLocalizations.of(context)!.pleaseEnterYourDetails,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 15,
              ),

              // Username TextField
              TextFormField(
                key: const Key('usernameForm'),
                style: Theme.of(context).textTheme.bodyMedium,
                onChanged: (value) => AppBlocs.authenticationViewBloc.add(UpdateUsernameValueEvent(value: value)),
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.username,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0), // Spacing between fields

              // Password TextField
              PasswordField(
                key: const Key('passwordForm'),
                passwordController: passwordController,
              ),
              const SizedBox(height: 30.0), // Spacing before button

              // Login Button
              Row(
                children: [
                  SizedBox(
                      child: CustomElevatedButton(
                    key: const Key('LoginButton'),
                    backgroundColor: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                    trailing: Icon(FontAwesomeIcons.arrowLeft, color: Theme.of(context).colorScheme.surface),
                    onTap: () => Navigator.of(context).pushReplacementNamed(RouteNames.getStartedPage),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: CustomElevatedButton(
                    backgroundColor: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                    text: AppLocalizations.of(context)!.login,
                    textColor: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : const Color.fromARGB(255, 44, 43, 50),
                    onTap: () => AppBlocs.authenticationViewBloc.add(PerformAuthenticationEvent()),
                  )),
                ],
              ),

              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dontHaveAnAccount,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).pushReplacementNamed(RouteNames.registrationPage),
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.blue),
                      ))
                ],
              ),

              const SizedBox(height: 30.0),

              SizedBox(
                width: 20,
                child: BlocBuilder<AuthenticationViewBloc, AuthenticationViewState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state is AuthenticationSuccesfulState) {
                      BlocProvider.of<AuthSessionBloc>(context).add(AuthSessionUpdatedEvent(state.session));
                      // Schedule the snackbar to be shown after the current frame
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)!.loginSuccess),
                          ),
                        );
                        //BlocProviders.authentication(context).add(AuthResetEvent());
                        Navigator.of(context).pop();

                        Navigator.of(context).pushReplacementNamed(RouteNames.homePage);
                      });
                    }

                    if (state is AuthenticationLoadingState) {
                      return const CircularProgressIndicator();
                    }

                    if (state is AuthenticationFailedState) {
                      // Schedule the snackbar to be shown after the current frame
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(convertFailTypeToString(context, state.reason)),
                          ),
                        );
                      });

                      AppBlocs.authenticationViewBloc.add(AuthResetEvent());
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordField({super.key, required this.passwordController});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  // State variable to toggle password visibility
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: (value) => AppBlocs.authenticationViewBloc.add(UpdatePasswordValueEvent(value: value)),
      controller: widget.passwordController,
      obscureText: !_isPasswordVisible, // Hide or show the password
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.password,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            // Toggle icon based on password visibility
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            // Toggle the state to show/hide password
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }
}
