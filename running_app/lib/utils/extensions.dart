import 'package:domain/entities/local_map_style_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/domain/sections/road_section_entity.dart';
import 'package:shared/domain/sections/steep_section_entity.dart';
import 'package:shared/domain/sections/surface_section_entity.dart';

extension MapStylesExtension on MapStyles {
  String getLabel(BuildContext context) {
    switch (this) {
      case MapStyles.cycle:
        return AppLocalizations.of(context)!.cycle;
      case MapStyles.satellite:
        return AppLocalizations.of(context)!.satellite('other');
      case MapStyles.satelliteElevated:
        return AppLocalizations.of(context)!.satellite('true');
      case MapStyles.elevation:
        return AppLocalizations.of(context)!.elevation;
      case MapStyles.magicDay:
        return AppLocalizations.of(context)!.magicDay;
      case MapStyles.magicNight:
        return AppLocalizations.of(context)!.magicNight;
    }
  }
}

extension DSteepnessExtenstion on DSteepness {
  Icon? getArrowIconBasedOnSteepness(Color horizontalArrowColor) {
    switch (this) {
      case DSteepness.descendExtreme ||
            DSteepness.descendVeryHigh ||
            DSteepness.descendHigh ||
            DSteepness.descendLow ||
            DSteepness.descendVeryLow:
        return const Icon(CupertinoIcons.arrow_down_right_circle_fill,
            color: Color.fromARGB(255, 112, 216, 115), size: 22);
      case DSteepness.neutral:
        return Icon(CupertinoIcons.arrow_right_circle_fill, color: horizontalArrowColor, size: 25);
      case DSteepness.ascendExtreme ||
            DSteepness.ascendVeryHigh ||
            DSteepness.ascendHigh ||
            DSteepness.ascendLow ||
            DSteepness.ascendVeryLow:
        return const Icon(CupertinoIcons.arrow_up_right_circle_fill, color: Color.fromARGB(255, 201, 73, 73), size: 25);
    }
  }

  String getPercentBasedOnSteepness() {
    switch (this) {
      case DSteepness.descendExtreme || DSteepness.ascendExtreme:
        return "16%+";
      case DSteepness.descendVeryHigh || DSteepness.ascendVeryHigh:
        return "10-15%";
      case DSteepness.descendHigh || DSteepness.ascendHigh:
        return "7-9%";
      case DSteepness.descendLow || DSteepness.ascendLow:
        return "4-6%";
      case DSteepness.descendVeryLow || DSteepness.ascendVeryLow:
        return "1-3%";
      case DSteepness.neutral:
        return "0%";
    }
  }

  Color getColorBasedOnSteepness() {
    switch (this) {
      case DSteepness.descendExtreme:
        return const Color.fromARGB(255, 4, 120, 8);
      case DSteepness.descendVeryHigh:
        return const Color.fromARGB(255, 38, 151, 41);
      case DSteepness.descendHigh:
        return const Color.fromARGB(255, 73, 183, 76);
      case DSteepness.descendLow:
        return const Color.fromARGB(255, 112, 216, 115);
      case DSteepness.descendVeryLow:
        return const Color.fromARGB(255, 154, 250, 156);
      case DSteepness.neutral:
        return const Color.fromARGB(255, 255, 197, 142);
      case DSteepness.ascendVeryLow:
        return const Color.fromARGB(255, 240, 141, 141);
      case DSteepness.ascendLow:
        return const Color.fromARGB(255, 220, 105, 105);
      case DSteepness.ascendHigh:
        return const Color.fromARGB(255, 201, 73, 73);
      case DSteepness.ascendVeryHigh:
        return const Color.fromARGB(255, 182, 42, 42);
      case DSteepness.ascendExtreme:
        return const Color.fromARGB(255, 164, 16, 16);
    }
  }
}

extension DSurfaceTypeExtension on DSurfaceType {
  String getStringBasedOnSurfaceType(BuildContext context) {
    switch (this) {
      case DSurfaceType.asphalt:
        return "Asphalt";
      case DSurfaceType.paved:
        return "Paved";
      case DSurfaceType.unpaved:
        return "Unpaved";
      case DSurfaceType.unknown:
        return "Unknown";
    }
  }

  Color getColorBasedOnSurfaceType() {
    switch (this) {
      case DSurfaceType.asphalt:
        return const Color.fromARGB(255, 127, 137, 149);

      case DSurfaceType.paved:
        return const Color.fromARGB(255, 212, 212, 212);

      case DSurfaceType.unknown:
        return const Color.fromARGB(255, 10, 10, 10);

      case DSurfaceType.unpaved:
        return const Color.fromARGB(255, 157, 133, 104);
    }
  }
}

extension DRoadTypeExtension on DRoadType {
  String getStringBasedOnRoadType(BuildContext context) {
    switch (this) {
      case DRoadType.motorway:
        return "Motorway";
      case DRoadType.stateRoad:
        return "State Road";
      case DRoadType.cycleway:
        return "Cycleway";
      case DRoadType.road:
        return "Road";
      case DRoadType.path:
        return "Path";
      case DRoadType.singleTrack:
        return "Single Track";
      case DRoadType.street:
        return "Street";
    }
  }

  Color getColorBasedOnRoadType() {
    switch (this) {
      case DRoadType.motorway:
        return const Color.fromARGB(255, 242, 144, 99);
      case DRoadType.stateRoad:
        return const Color.fromARGB(255, 242, 216, 99);
      case DRoadType.cycleway:
        return const Color.fromARGB(255, 15, 175, 135);
      case DRoadType.road:
        return const Color.fromARGB(255, 153, 163, 175);
      case DRoadType.path:
        return const Color.fromARGB(255, 196, 200, 211);
      case DRoadType.singleTrack:
        return const Color.fromARGB(255, 166, 133, 96);
      case DRoadType.street:
        return const Color.fromARGB(255, 175, 185, 193);
    }
  }
}
