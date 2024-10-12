import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';

Future<void> showEditImageActions(BuildContext context) async {
  final bloc = BlocProviders.editProfile(context);
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File image = File(pickedFile.path); // Get the image file
        final imageData = await image.readAsBytes();
        bloc.add(UpdateProfilePictureEvent(imageData: imageData));
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  await showModalBottomSheet(
    isDismissible: true,
    context: context,
    backgroundColor: Theme.of(context).colorScheme.onSecondary, // Background color of the container
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            CustomElevatedButton(
              onTap: () async {
                await _pickImage();
                Navigator.of(context).pop();
              },
              trailing: const Icon(
                FontAwesomeIcons.upload,
                size: 20.0,
              ),
              text: AppLocalizations.of(context)!.updatePhoto,
              backgroundColor: Theme.of(context).highlightColor,
            ),
            const SizedBox(height: 10.0),
            CustomElevatedButton(
              onTap: () {
                bloc.add(DeleteProfilePictureEvent());
                Navigator.of(context).pop();
              },
              trailing: const Icon(
                FontAwesomeIcons.trash,
                color: Colors.red,
                size: 20.0,
              ),
              text: AppLocalizations.of(context)!.deletePhoto,
              backgroundColor: Theme.of(context).highlightColor,
            ),
          ],
        ),
      );
    },
  );
}
