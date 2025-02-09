import 'package:domain/entities/alert_entity.dart';
import 'package:flutter/material.dart';
import 'package:running_app/alerts/widgets/alert_images.dart';

class LandmarkPanelHeader extends StatelessWidget {
  final AlertEntity alert;
  const LandmarkPanelHeader({
    super.key,
    required this.alert,
    required this.onCloseTap,
  });

  final VoidCallback onCloseTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          const NoImageAvailable(height: 140),
          Positioned(
            right: 10,
            top: 10,
            child: SizedBox.square(
              dimension: 30,
              child: CloseButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    padding: EdgeInsets.zero),
                onPressed: onCloseTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
