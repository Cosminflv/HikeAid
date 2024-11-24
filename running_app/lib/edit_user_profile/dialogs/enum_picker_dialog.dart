import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/user_profile_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';

class CupertinoEnumPickerDialog extends StatefulWidget {
  final EGenderEntity currentGender;

  const CupertinoEnumPickerDialog({super.key, required this.currentGender});

  @override
  // ignore: library_private_types_in_public_api
  _CupertinoEnumPickerDialogState createState() => _CupertinoEnumPickerDialogState();
}

class _CupertinoEnumPickerDialogState extends State<CupertinoEnumPickerDialog> {
  late EGenderEntity selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.currentGender; // Initialize with the current gender
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      color: Theme.of(context).highlightColor,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: CupertinoPicker(
              itemExtent: MediaQuery.of(context).size.height * 0.04,
              scrollController: FixedExtentScrollController(
                initialItem: EGenderEntity.values.indexOf(selectedGender),
              ),
              onSelectedItemChanged: (int index) {
                setState(() {
                  selectedGender = EGenderEntity.values[index]; // Update state with new gender
                });
              },
              children: EGenderEntity.values.map((EGenderEntity gender) {
                return Center(child: Text(gender.toReadableString()));
              }).toList(),
            ),
          ),
          CupertinoButton(
            child: const Text("Done"),
            onPressed: () {
              // Trigger the BLoC event with the selected enum value when Done is pressed
              AppBlocs.editProfileBloc.add(
                UpdateUserGenderEvent(newGender: selectedGender),
              );
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }
}
