import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:running_app/edit_user_profile/edit_user_profile_view_event.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';

import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:typed_data';

Future<void> showEditImageActions(BuildContext context) async {
  final bloc = AppBlocs.editProfileBloc;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        Uint8List imageData = await image.readAsBytes();

        img.Image? originalImage = img.decodeImage(imageData);

        if (originalImage != null) {
          // Step 3: Resize the image (adjust width and height as needed)
          img.Image resizedImage = img.copyResize(originalImage, width: 500); // e.g., width of 500px

          // Step 4: Encode the resized image back to bytes (JPEG for compression)
          Uint8List resizedImageData =
              Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85)); // quality can be set between 0-100
          bloc.add(UpdateProfilePictureEvent(imageData: resizedImageData));
        }
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
                _pickImage();
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
