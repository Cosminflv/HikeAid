import 'package:domain/entities/registration_status.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/onboarding/registration/registration_view_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_event.dart';
import 'package:running_app/onboarding/registration/registration_view_state.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/utils/debouncer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final Debouncer debouncer = Debouncer(milliseconds: Durations.long1.inMilliseconds);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    BlocProviders.registration(context).add(ClearRegistrationEvent());
    usernameController.clear();
    firstNameController.clear();
    lastNameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    super.initState();
  }

  bool _areFieldsFilled() {
    return usernameController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // Username TextField
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    usernameController.clear();
                    BlocProviders.registration(context).add(UpdateUsernameValueEvent(value: ""));
                  },
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => BlocProviders.registration(context).add(UpdateUsernameValueEvent(value: value)),
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0), // Spacing between fields

              // First Name TextField
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    firstNameController.clear();
                    BlocProviders.registration(context).add(UpdateFirstNameValueEvent(value: ""));
                  },
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => BlocProviders.registration(context).add(UpdateFirstNameValueEvent(value: value)),
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0), // Spacing between fields

              // Last Name TextField
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    lastNameController.clear();
                    BlocProviders.registration(context).add(UpdateLastNameValueEvent(value: ""));
                  },
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => BlocProviders.registration(context).add(UpdateLastNameValueEvent(value: value)),
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0), // Spacing between fields

              // Password TextField
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    passwordController.clear();
                    BlocProviders.registration(context).add(UpdatePasswordValueEvent(value: ""));
                  },
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => BlocProviders.registration(context).add(UpdatePasswordValueEvent(value: value)),
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0), // Spacing between fields

              // Confirm Password TextField
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    confirmPasswordController.clear();
                  },
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) {},
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0), // Spacing before button

              // Register Button
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
                        if (_areFieldsFilled()) {
                          if (passwordController.text == confirmPasswordController.text) {
                            debouncer.run(() => BlocProviders.registration(context).add(PerformRegistrationEvent()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Passwords do not match"),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill in all fields"),
                            ),
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30.0),

              SizedBox(
                width: 20,
                child: BlocBuilder<RegistrationViewBloc, RegistrationViewState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state is RegistrationSuccesfulState) {
                      // Schedule the snackbar to be shown after the current frame
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Registration successful"),
                          ),
                        );
                        // TODO: Navigate to LoginPage or another relevant page
                        BlocProviders.registration(context).add(ClearRegistrationEvent());
                        Navigator.of(context).pushReplacementNamed(RouteNames.authenticationPage);
                      });
                    }

                    if (state is RegistrationLoadingState) {
                      return const CircularProgressIndicator();
                    }

                    if (state is RegistrationFailedState) {
                      // Schedule the snackbar to be shown after the current frame
                      SchedulerBinding.instance.addPostFrameCallback((reason) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.reason.description),
                          ),
                        );
                      });
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
