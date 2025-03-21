import 'package:flutter/material.dart';
import 'package:running_app/alerts/widgets/alert_images.dart';
import 'dart:typed_data';

import 'package:running_app/user_profile/widgets/profile_image_dialog.dart';

class LandmarkPanelHeader extends StatelessWidget {
  final Future<Uint8List?> alertImageFuture;
  final VoidCallback onCloseTap;

  const LandmarkPanelHeader({
    super.key,
    required this.alertImageFuture,
    required this.onCloseTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          FutureBuilder<Uint8List?>(
            future: alertImageFuture,
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500), // Smooth transition duration
                switchInCurve: Curves.easeInOut, // Animation curve
                switchOutCurve: Curves.easeInOut,
                child: snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data == null
                    ? const NoImageAvailable(height: 140, key: ValueKey('no_image')) // Unique key for animation
                    : GestureDetector(
                        onTap: () {
                          profileImageDialog(context, snapshot.data!);
                        },
                        child: Image.memory(
                          snapshot.data!,
                          height: 140,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                          key: const ValueKey('image_loaded'), // Key to trigger animation
                        ),
                      ),
              );
            },
          ),
          Positioned(
            right: 10,
            top: 10,
            child: SizedBox.square(
              dimension: 30,
              child: CloseButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  padding: EdgeInsets.zero,
                ),
                onPressed: onCloseTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
