import 'package:domain/entities/local_map_style_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



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