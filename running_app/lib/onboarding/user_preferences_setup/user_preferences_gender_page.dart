import 'package:domain/entities/user_profile_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/edit_user_profile/dialogs/profile_item_picker.dart';
import 'package:running_app/onboarding/user_preferences_setup/user_preferences_page_template.dart';

enum Gender { male, female, other }

class UserGenderPage extends StatefulWidget {
  final EGenderEntity initialGender;
  final Function(EGenderEntity) onGenderChanged;

  const UserGenderPage({
    super.key,
    required this.initialGender,
    required this.onGenderChanged,
  });

  @override
  State<UserGenderPage> createState() => _UserGenderPageState();
}

class _UserGenderPageState extends State<UserGenderPage> {
  late EGenderEntity currentGender;

  @override
  void initState() {
    super.initState();
    currentGender = widget.initialGender;
  }

  @override
  Widget build(BuildContext context) {
    return UserPreferencesPageTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please select your gender",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          ProfileItemPicker<Gender>(
            title: "Gender",
            value: _genderToString(currentGender),
            onTap: (context) => showCupertinoModalPopup(
              context: context,
              builder: (_) => CupertinoGenderPickerDialog(
                currentGender: currentGender,
                onGenderSelected: (newGender) {
                  widget.onGenderChanged(newGender); // Trigger the callback
                  setState(() {
                    currentGender = newGender;
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

  String _genderToString(EGenderEntity gender) {
    switch (gender) {
      case EGenderEntity.man:
        return "Male";
      case EGenderEntity.woman:
        return "Female";
    }
  }
}

class CupertinoGenderPickerDialog extends StatelessWidget {
  final EGenderEntity currentGender;
  final ValueChanged<EGenderEntity> onGenderSelected;

  const CupertinoGenderPickerDialog({
    super.key,
    required this.currentGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    int selectedIndex = EGenderEntity.values.indexOf(currentGender);

    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: selectedIndex),
              itemExtent: 32,
              onSelectedItemChanged: (index) {
                selectedIndex = index;
              },
              children: EGenderEntity.values
                  .map((gender) => Text(_genderToString(gender), textAlign: TextAlign.center))
                  .toList(),
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
                  onGenderSelected(EGenderEntity.values[selectedIndex]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _genderToString(EGenderEntity gender) {
    switch (gender) {
      case EGenderEntity.man:
        return "Male";
      case EGenderEntity.woman:
        return "Female";
      default:
        return "";
    }
  }
}
