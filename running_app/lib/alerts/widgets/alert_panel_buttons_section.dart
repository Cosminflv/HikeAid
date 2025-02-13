import 'package:flutter/material.dart';
import 'package:running_app/landmark_panel/widgets/landmark_panel_button.dart';

class AlertPanelButtonsSection extends StatelessWidget {
  final VoidCallback onInvalidButtonTap;
  final VoidCallback onValidButtonTap;
  const AlertPanelButtonsSection({super.key, required this.onInvalidButtonTap, required this.onValidButtonTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LandmarkPanelButton(text: "Not valid anymore", onTap: onInvalidButtonTap, isFilled: false),
        LandmarkPanelButton(text: "Validate", onTap: onValidButtonTap, isFilled: true)
      ],
    );
  }
}
