import 'package:flutter/material.dart';
import 'package:running_app/config/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingMenuPage extends StatelessWidget {
  const OnboardingMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        leading: IconButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pushReplacementNamed(RouteNames.getStartedPage),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            // Get Started button at the bottom of the screen
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(RouteNames.authenticationPage);
                  },
                  child: Text(AppLocalizations.of(context)!.login),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(RouteNames.registrationPage);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.register,
                  ),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
