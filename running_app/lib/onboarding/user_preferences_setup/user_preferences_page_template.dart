import 'package:flutter/material.dart';

class UserPreferencesPageTemplate extends StatelessWidget {
  final Widget child;

  const UserPreferencesPageTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(child: child),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
