import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/edit_user_profile/dialogs/profile_item_picker.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_page_template.dart';

class UserWeightPage extends StatelessWidget {
  final int initialWeight;
  final Function(int) onChanged;
  const UserWeightPage({super.key, required this.initialWeight, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return UserPreferencesPageTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tell us about your weight",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          ProfileItemPicker<int>(
            title: "Weight (kg)",
            value: initialWeight.toString(),
            onTap: (context) => showCupertinoModalPopup(
              context: context,
              builder: (_) => CupertinoWeightPickerDialog(
                currentWeight: initialWeight,
                onWeightSelected: (newWeight) {
                  onChanged(newWeight); // Call the onChanged function
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CupertinoWeightPickerDialog extends StatelessWidget {
  final int currentWeight;
  final ValueChanged<int> onWeightSelected;

  const CupertinoWeightPickerDialog({
    super.key,
    required this.currentWeight,
    required this.onWeightSelected,
  });

  @override
  Widget build(BuildContext context) {
    int selectedWeight = currentWeight;

    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: currentWeight - 30, // Adjust index to match weight
              ),
              itemExtent: 32,
              onSelectedItemChanged: (index) {
                selectedWeight = index + 30; // Adjust index to weight range
              },
              children: List<Widget>.generate(
                121, // Assume weight range is 30–229 kg
                (index) => Text("${index + 30} kg"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoButton(
                child: const Text("Done"),
                onPressed: () {
                  onWeightSelected(selectedWeight); // Pass the selected weight
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
