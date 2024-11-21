

import 'package:domain/entities/landmark_with_distance_entity.dart';

import 'package:flutter/material.dart';
import 'package:running_app/utils/sizes.dart';
import 'package:running_app/utils/unit_converters.dart';

class LandmarkListItem extends StatelessWidget {
  final LandmarkWithDistanceEntity landmark;
  final VoidCallback onTap;
  final bool showExtraImage;

  const LandmarkListItem({super.key, required this.landmark, required this.onTap, this.showExtraImage = false});

  @override
  Widget build(BuildContext context) {
    final image = showExtraImage ? landmark.landmark.extraImage : landmark.icon;
    
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          InkWell(
            highlightColor: Theme.of(context).colorScheme.outlineVariant,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (image != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Image.memory(
                        image,
                        width: Sizes.landmarkIconSize,
                        height: Sizes.landmarkIconSize,
                      ),
                    ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          landmark.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(landmark.address.trim(),
                                overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
                            Text(
                              convertDistance(landmark.distance, getDistanceUnit(context)),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
