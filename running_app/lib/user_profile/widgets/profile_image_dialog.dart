import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<dynamic> profileImageDialog(BuildContext context, Uint8List imageData) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: Image.memory(imageData),
            ),
            Positioned(
              top: 1,
              right: 1,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.x,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 20.0,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
