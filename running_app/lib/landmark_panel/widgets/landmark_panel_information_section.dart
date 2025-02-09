import 'package:domain/entities/landmark_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandmarkPanelInformationSection extends StatelessWidget {
  final VoidCallback onCloseTap;

  const LandmarkPanelInformationSection({
    super.key,
    required this.landmark,
    required this.onCloseTap,
  });

  final LandmarkEntity landmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                landmark.name.isNotEmpty ? landmark.name.trim() : 'Map Pin',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (landmark.address.trim().isNotEmpty)
                Text(
                  landmark.address.trim(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          )),
          IconButton(
            icon: const Icon(FontAwesomeIcons.xmark),
            onPressed: onCloseTap,
          ),
        ],
      ),
    );
  }
}
