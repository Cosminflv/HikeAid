import 'package:core/di/app_blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';

class CupertinoDatePickerDialog extends StatefulWidget {
  final DateTime currentBirthDate;

  const CupertinoDatePickerDialog({super.key, required this.currentBirthDate});

  @override
  // ignore: library_private_types_in_public_api
  _CupertinoDatePickerDialogState createState() => _CupertinoDatePickerDialogState();
}

class _CupertinoDatePickerDialogState extends State<CupertinoDatePickerDialog> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.currentBirthDate; // Initialize with the current birth date
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
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  selectedDate = newDateTime; // Update the selected date
                });
              },
            ),
          ),
          CupertinoButton(
            child: const Text("Done"),
            onPressed: () {
              // Trigger the BLoC event with the new date when Done is pressed
              AppBlocs.editProfileBloc.add(
                UpdateUserBirthDateEvent(newDateTime: selectedDate),
              );
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }
}
