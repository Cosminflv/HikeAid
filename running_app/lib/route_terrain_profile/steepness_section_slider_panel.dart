// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:running_app/utils/extensions.dart';
import 'package:shared/domain/sections/base_section_entity.dart';
import 'package:shared/domain/sections/steep_section_entity.dart';

import 'named_card.dart';
import 'section_slider.dart';

class SteepnessSectionSlider extends StatelessWidget {
  final List<SteepSectionEntity> sections;
  final int routeLength;
  final bool isInteractive;
  final void Function(BaseSectionEntity, Color) onSelectionChanged;

  const SteepnessSectionSlider(
      {super.key,
      required this.sections,
      required this.routeLength,
      required this.onSelectionChanged,
      required this.isInteractive});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 140),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return NamedCard(
            title: "Steepness",
            isInteractive: isInteractive,
            content: SectionSlider(
              sections: sections,
              width: constraints.maxWidth,
              distance: routeLength,
              getArrowIcon: (e) {
                return (e.type as DSteepness)
                    .getArrowIconBasedOnSteepness(Theme.of(context).colorScheme.onSurfaceVariant);
              },
              onSelectionChanged: (section) =>
                  onSelectionChanged(section, (section.type as DSteepness).getColorBasedOnSteepness()),
              getName: (e) {
                return (e.type as DSteepness).getPercentBasedOnSteepness();
              },
              getColor: (e) {
                return (e.type as DSteepness).getColorBasedOnSteepness();
              },
            ),
            onDetailsTap: () {},
          );
        },
      ),
    );
  }
}
