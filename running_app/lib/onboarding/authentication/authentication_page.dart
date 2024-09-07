import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/onboarding/authentication/authentication_view_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_event.dart';
import 'package:running_app/onboarding/authentication/authentication_view_state.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/utils/debouncer.dart';

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
    BlocProviders.authentication(context).add(AuthClearEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Username TextField
            TextFormField(
              onChanged: (value) => BlocProviders.authentication(context).add(UpdateUsernameValueEvent(value: value)),
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0), // Spacing between fields

            // Password TextField
            TextFormField(
              onChanged: (value) => BlocProviders.authentication(context).add(UpdatePasswordValueEvent(value: value)),
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0), // Spacing before button

            // Login Button
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(RouteNames.onboardingMenuPage),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      debouncer.run(() => BlocProviders.authentication(context).add(PerformAuthenticationEvent()));
                    },
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30.0),

            SizedBox(
              width: 20,
              child: BlocBuilder<AuthenticationViewBloc, AuthenticationViewState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state is AuthenticationSuccesfulState) {
                    // Schedule the snackbar to be shown after the current frame
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Login successful"),
                        ),
                      );
                      // TODO: Navigate to MapPage

                      BlocProviders.authentication(context).add(AuthResetEvent());
                    });
                  }

                  if (state is AuthenticationLoadingState) {
                    return const CircularProgressIndicator();
                  }

                  if (state is AuthenticationFailedState) {
                    // Schedule the snackbar to be shown after the current frame
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid username or password"),
                        ),
                      );
                    });

                    BlocProviders.authentication(context).add(AuthResetEvent());
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
