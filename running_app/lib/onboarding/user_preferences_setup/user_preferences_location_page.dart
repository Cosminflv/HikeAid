import 'package:flutter/material.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_page_template.dart';

class UserLocationPage extends StatefulWidget {
  final String initialCity;
  final String initialCountry;
  final Function(String) onCityValueChanged;
  final Function(String) onCountryValueChanged;

  const UserLocationPage(
      {super.key,
      required this.onCityValueChanged,
      required this.onCountryValueChanged,
      required this.initialCity,
      required this.initialCountry});

  @override
  State<UserLocationPage> createState() => _UserLocationPageState();
}

class _UserLocationPageState extends State<UserLocationPage> {
  late TextEditingController cityTextController;
  late TextEditingController countryTextController;

  @override
  void initState() {
    super.initState();
    cityTextController = TextEditingController(text: widget.initialCity);
    countryTextController = TextEditingController(text: widget.initialCountry);
  }

  @override
  Widget build(BuildContext context) {
    return UserPreferencesPageTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Where are you from?",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
            controller: cityTextController,
            onChanged: widget.onCityValueChanged, // Call the city callback when changed
          ),
          const SizedBox(height: 16), // Add spacing between fields
          TextField(
            decoration: const InputDecoration(
              labelText: 'Country',
              border: OutlineInputBorder(),
            ),
            controller: countryTextController,
            onChanged: widget.onCountryValueChanged, // Call the country callback when changed
          ),
        ],
      ),
    );
  }
}
