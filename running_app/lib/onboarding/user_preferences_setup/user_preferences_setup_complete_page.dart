import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_page_template.dart';

class UserSetupCompletePage extends StatelessWidget {
  const UserSetupCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPreferencesPageTemplate(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          FontAwesomeIcons.check,
          size: 50,
        ),
        Text(
          "Well done, profile all set up.",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    ));
  }
}
