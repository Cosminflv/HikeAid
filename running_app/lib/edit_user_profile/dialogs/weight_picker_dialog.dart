import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/providers/bloc_providers.dart';

class CupertinoWeightPickerDialog extends StatefulWidget {
  final int currentWeight;

  const CupertinoWeightPickerDialog({super.key, required this.currentWeight});

  @override
  // ignore: library_private_types_in_public_api
  _CupertinoWeightPickerDialogState createState() => _CupertinoWeightPickerDialogState();
}

class _CupertinoWeightPickerDialogState extends State<CupertinoWeightPickerDialog> {
  late int selectedWeight;

  final int minWeight = 30; // Minimum weight
  final int maxWeight = 150; // Maximum weight

  @override
  void initState() {
    super.initState();
    selectedWeight = widget.currentWeight; // Initialize with the current weight
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      color: Theme.of(context).highlightColor,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: CupertinoPicker(
              itemExtent: 32.0, // Height of each item
              scrollController: FixedExtentScrollController(
                initialItem: selectedWeight - minWeight, // Initialize at the current weight
              ),
              onSelectedItemChanged: (int index) {
                setState(() {
                  selectedWeight = minWeight + index; // Update selected weight
                });
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
              // Trigger the BLoC event with the new weight value when Done is pressed
              BlocProviders.editProfile(context).add(
                UpdateUserWeightEvent(newWeight: selectedWeight),
              );
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }
}
