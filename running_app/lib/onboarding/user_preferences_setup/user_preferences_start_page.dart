import 'package:flutter/material.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_page_template.dart';

class UserPreferencesStartPage extends StatelessWidget {
  const UserPreferencesStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPreferencesPageTemplate(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome!',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 10.0),
              Text(
                'Personalize your hiking experience by setting up your profile.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20.0),
              Text(
                'Why set preferences?',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By telling us about you, we can:',
                      style: TextStyle(fontSize: 16.0, color: Theme.of(context).colorScheme.onSurface),
                    ),
                    const TextSpan(text: '\n'),
                    const TextSpan(
                      text: '\n • Offer hike suggestions personalized for you.',
                      style: TextStyle(fontSize: 16.0, color: Colors.green),
                    ),
                    const TextSpan(text: '\n'),
                    const TextSpan(
                      text: '\n • Tailor hike suggestions to your level.',
                      style: TextStyle(fontSize: 16.0, color: Colors.green),
                    ),
                    const TextSpan(text: '\n'),
                    const TextSpan(
                      text: '\n • Provide more accurate estimates of effort and distance.',
                      style: TextStyle(fontSize: 16.0, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
