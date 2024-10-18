import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/providers/bloc_providers.dart';

void showCupertinoDatePickerDialog(BuildContext context, DateTime currentBirthDate) {
  showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      height: 300, // Adjust the height as needed
      color: Theme.of(context).highlightColor,
      child: Column(
        children: [
          SizedBox(
            height: 200, // Height of the date picker
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: currentBirthDate,
              onDateTimeChanged: (DateTime newDateTime) {
                // Trigger the BLoC event with the new date
                BlocProviders.editProfile(context).add(UpdateUserBirthDateEvent(newDateTime: newDateTime));
              },
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
