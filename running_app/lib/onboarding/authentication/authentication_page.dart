import 'package:flutter/material.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/onboarding/authentication/authentication_view_event.dart';
import 'package:running_app/providers/bloc_providers.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Username TextField
            TextFormField(
              onChanged: (value) =>
                  BlocProviders.authentication(context).add(UpdateLoginUsernameValueEvent(value: value)),
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0), // Spacing between fields

            // Password TextField
            TextFormField(
              onChanged: (value) =>
                  BlocProviders.authentication(context).add(UpdateLoginPasswordValueEvent(value: value)),
              controller: _passwordController,
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
                      BlocProviders.authentication(context).add(PerformAuthenticationEvent());
                    },
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
