import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/providers/bloc_providers.dart';

void showCupertinoWeightPickerDialog(BuildContext context, int currentWeight) {
  // Define the range for weight (you can adjust this range)
  final int minWeight = 30;  // Minimum weight
  final int maxWeight = 150; // Maximum weight

  showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      height: 300, // Adjust the height as needed
      color: Theme.of(context).highlightColor,
      child: Column(
        children: [
          SizedBox(
            height: 200, // Height of the picker
            child: CupertinoPicker(
              itemExtent: 32.0, // Height of each item
              scrollController: FixedExtentScrollController(
                initialItem: currentWeight - minWeight, // Initialize at the current weight
              ),
              onSelectedItemChanged: (int index) {
                final selectedWeight = minWeight + index; // Get selected weight

                // Trigger the BLoC event with the new weight value
                BlocProviders.editProfile(context).add(
                  UpdateUserWeightEvent(newWeight: selectedWeight),
                );
              },
              children: List<Widget>.generate(
                maxWeight - minWeight + 1,
                (index) => Center(
                  child: Text('${minWeight + index} kg'), // Display weight values
                ),
              ),
            ),
          ),
          CupertinoButton(
            child: const Text("Done"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    ),
  );
}
