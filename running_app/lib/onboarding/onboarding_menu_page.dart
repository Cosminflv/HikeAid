import 'package:flutter/material.dart';
import 'package:running_app/config/routes.dart';

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
                    //Navigator.of(context).pushReplacementNamed(RouteNames.authenticationPage);
                  },
                  child: const Text('Log in'),
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
                    //Navigator.of(context).pushReplacementNamed(RouteNames.authenticationPage);
                  },
                  child: const Text('Register'),
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
