import 'package:flutter/material.dart';
import 'package:running_app/config/routes.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Spacer to push the widget to the center
          const Spacer(),

          // Placeholder for the widget in the middle of the screen
          Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: const Text(
                'Welcome to the App!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Spacer to maintain the middle widget position
          const Spacer(),

          // Get Started button at the bottom of the screen
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(RouteNames.onboardingMenuPage);
                },
                child: const Text('Get Started'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
