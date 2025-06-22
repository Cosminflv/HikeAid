import 'package:domain/settings/general_settings_entity.dart';
import 'package:running_app/utils/extensions.dart';
import 'package:running_app/utils/unit_converters.dart';
import 'package:shared/domain/sections/base_section_entity.dart';
import 'package:shared/domain/sections/road_section_entity.dart';

import 'named_card.dart';
import 'section_slider.dart';

import 'package:flutter/cupertino.dart';

class WaysSectionSlider extends StatelessWidget {
  final List<RoadSectionEntity> sections;
  final void Function(BaseSectionEntity, Color) onSelectionChanged;
  final int routeLength;
  final bool isInteractive;
  final VoidCallback? onDetailsTap;
  final RoadSectionEntity? selectedSection;

  const WaysSectionSlider({
    super.key,
    required this.sections,
    required this.onSelectionChanged,
    required this.routeLength,
    required this.isInteractive,
    this.selectedSection,
    this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 140),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return NamedCard(
            title: "Way Types",
            isInteractive: isInteractive,
            onDetailsTap: onDetailsTap,
            subtitle: selectedSection == null
                ? null
                : '${(selectedSection!.type).getStringBasedOnRoadType(context)}: ${convertDistance(selectedSection!.sectionLength, DDistanceUnit.km)}',
            content: SectionSlider(
              sections: sections,
              isInteractive: isInteractive,
              width: constraints.maxWidth,
              getArrowIcon: (e) => null,
              distance: routeLength,
              onSelectionChanged: (section) =>
                  onSelectionChanged(section, (section.type as DRoadType).getColorBasedOnRoadType()),
              getName: (e) {
                return (e.type as DRoadType).getStringBasedOnRoadType(context);
              },
              getColor: (e) {
                return (e.type as DRoadType).getColorBasedOnRoadType();
              },
            ),
          );
        },
      ),
    );
  }
}
