import 'package:domain/settings/general_settings_entity.dart';

import 'package:flutter/cupertino.dart';
import 'package:running_app/utils/extensions.dart';
import 'package:running_app/utils/unit_converters.dart';
import 'package:shared/domain/sections/base_section_entity.dart';
import 'package:shared/domain/sections/surface_section_entity.dart';

import 'named_card.dart';
import 'section_slider.dart';

class SurfacesSectionSlider extends StatelessWidget {
  final List<SurfaceSectionEntity> sections;
  final void Function(BaseSectionEntity, Color) onSelectionChanged;
  final int routeLength;
  final bool isInteractive;
  final VoidCallback? onDetailsTap;
  final SurfaceSectionEntity? selectedSection;

  const SurfacesSectionSlider({
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
      child: LayoutBuilder(builder: (context, constraints) {
        return NamedCard(
          title: "Surfaces",
          isInteractive: isInteractive,
          onDetailsTap: onDetailsTap,
          subtitle: selectedSection == null
              ? null
              : '${(selectedSection!.type).getStringBasedOnSurfaceType(context)}: ${convertDistance(selectedSection!.sectionLength, DDistanceUnit.km)}',
          content: SectionSlider(
            sections: sections,
            isInteractive: isInteractive,
            width: constraints.maxWidth,
            distance: routeLength,
            getArrowIcon: (e) => null,
            onSelectionChanged: (section) =>
                onSelectionChanged(section, (section.type as DSurfaceType).getColorBasedOnSurfaceType()),
            getName: (e) {
              return (e.type as DSurfaceType).getStringBasedOnSurfaceType(context);
            },
            getColor: (e) {
              return (e.type as DSurfaceType).getColorBasedOnSurfaceType();
            },
          ),
        );
      }),
    );
  }
}
