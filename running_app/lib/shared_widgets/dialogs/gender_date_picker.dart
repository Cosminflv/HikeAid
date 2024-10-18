import 'package:domain/entities/user_profile_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/providers/bloc_providers.dart';

void showCupertinoEnumPickerDialog(BuildContext context, EGenderEntity currentGender) {
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
                initialItem: EGenderEntity.values.indexOf(currentGender),
              ),
              onSelectedItemChanged: (int index) {
                final selectedGender = EGenderEntity.values[index];

                // Trigger the BLoC event with the new enum value
                BlocProviders.editProfile(context).add(
                  UpdateUserGenderEvent(newGender: selectedGender),
                );
              },
              children: EGenderEntity.values.map((EGenderEntity gender) {
                return Center(child: Text(gender.toString().split('.').last));
              }).toList(),
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
