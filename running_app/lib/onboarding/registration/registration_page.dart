import 'package:core/di/app_blocs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/onboarding/registration/registration_view_event.dart';

import 'package:running_app/shared_widgets/custom_text_button.dart';
import 'package:running_app/utils/debouncer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    AppBlocs.registrationViewBloc.add(ClearRegistrationEvent());
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
                    AppBlocs.registrationViewBloc.add(UpdateUsernameValueEvent(value: ""));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.clear,
                    style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => AppBlocs.registrationViewBloc.add(UpdateUsernameValueEvent(value: value)),
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.username,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0), // Spacing between fields

              // First Name TextField
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    firstNameController.clear();
                    AppBlocs.registrationViewBloc.add(UpdateFirstNameValueEvent(value: ""));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.clear,
                    style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => AppBlocs.registrationViewBloc.add(UpdateFirstNameValueEvent(value: value)),
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.firstName,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0), // Spacing between fields

              // Last Name TextField
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    lastNameController.clear();
                    AppBlocs.registrationViewBloc.add(UpdateLastNameValueEvent(value: ""));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.clear,
                    style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => AppBlocs.registrationViewBloc.add(UpdateLastNameValueEvent(value: value)),
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.lastName,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0), // Spacing between fields

              // Password TextField
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    passwordController.clear();
                    AppBlocs.registrationViewBloc.add(UpdatePasswordValueEvent(value: ""));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.clear,
                    style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => AppBlocs.registrationViewBloc.add(UpdatePasswordValueEvent(value: value)),
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.password,
                  border: const OutlineInputBorder(),
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
                  child: Text(
                    AppLocalizations.of(context)!.clear,
                    style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) => {},
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.confirmPassword,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0), // Spacing before button

              // Register Button
              Row(
                children: [
                  SizedBox(
                      child: CustomElevatedButton(
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
                    text: AppLocalizations.of(context)!.signUp,
                    textColor: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : const Color.fromARGB(255, 44, 43, 50),
                    onTap: () {
                      if (_areFieldsFilled()) {
                        if (passwordController.text == confirmPasswordController.text) {
                          debouncer.run(
                              () => Navigator.of(context).pushReplacementNamed(RouteNames.userPreferencesWizardPage));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!.noMatchPassword),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)!.fillAllFields),
                          ),
                        );
                      }
                    },
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
