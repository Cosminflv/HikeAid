import 'package:core/di/app_blocs.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';
import 'package:running_app/utils/image_picker_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:typed_data';

Future<void> showEditImageActions(BuildContext context) async {
  final bloc = AppBlocs.editProfileBloc;
  final imageCompressorService = ImagePickerService();

  Future<Uint8List?> pickImage() async {
    return await imageCompressorService.pickAndCompressImage(minHeight: 500, minWidth: 500);
  }

  await showModalBottomSheet(
    isDismissible: true,
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface, // Background color of the container
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
                final imageData = await pickImage();
                if (imageData != null) bloc.add(UpdateProfilePictureEvent(imageData: imageData));

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              trailing: const Icon(
                FontAwesomeIcons.upload,
                size: 20.0,
              ),
              text: AppLocalizations.of(context)!.updatePhoto,
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
            ),
          ],
        ),
      );
    },
  );
}
