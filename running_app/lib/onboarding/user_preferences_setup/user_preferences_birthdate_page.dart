import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/edit_user_profile/dialogs/profile_item_picker.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_page_template.dart';

class UserBirthdatePage extends StatefulWidget {
  final DateTime initialBirthdate;
  final Function(DateTime) onBirthdateChanged;

  const UserBirthdatePage({
    super.key,
    required this.initialBirthdate,
    required this.onBirthdateChanged,
  });

  @override
  State<UserBirthdatePage> createState() => _UserBirthdatePageState();
}

class _UserBirthdatePageState extends State<UserBirthdatePage> {
  late DateTime selectedBirthdate;

  @override
  void initState() {
    super.initState();
    selectedBirthdate = widget.initialBirthdate;
  }

  @override
  Widget build(BuildContext context) {
    return UserPreferencesPageTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please select your birthdate",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          ProfileItemPicker<DateTime>(
            title: "Birthdate",
            value: _formatDate(selectedBirthdate),
            onTap: (context) => showCupertinoModalPopup(
              context: context,
              builder: (_) => CupertinoDatePickerDialog(
                currentBirthdate: selectedBirthdate,
                onDateSelected: (newDate) {
                  widget.onBirthdateChanged(newDate); // Notify parent of the change
                  setState(() {
                    selectedBirthdate = newDate;
                  });
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}

class CupertinoDatePickerDialog extends StatelessWidget {
  final DateTime currentBirthdate;
  final ValueChanged<DateTime> onDateSelected;

  const CupertinoDatePickerDialog({
    super.key,
    required this.currentBirthdate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = currentBirthdate;

    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: currentBirthdate,
              maximumDate: DateTime.now(),
              minimumDate: DateTime(1900),
              onDateTimeChanged: (newDate) {
                selectedDate = newDate;
              },
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
                  onDateSelected(selectedDate); // Pass selected date
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
