import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:typed_data';

class AlertImage extends StatelessWidget {
  final Uint8List? imageData;
  final double height;

  const AlertImage({
    super.key,
    required this.imageData,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (imageData != null) {
      return Image.memory(
        imageData!, // Your Uint8List image data
        height: height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const ImageLoadFailed(); // Handle error case
        },
      );
    }
    return NoImageAvailable(height: height);
  }
}

class ImageLoadFailed extends StatelessWidget {
  const ImageLoadFailed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(FontAwesomeIcons.circleExclamation),
        SizedBox(height: 10),
        Text("Image failed to load", textAlign: TextAlign.center),
      ],
    );
  }
}

class NoImageAvailable extends StatelessWidget {
  final double height;
  const NoImageAvailable({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/no_image_found.png',
      height: height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
