import 'package:core/di/app_blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../map_styles/map_styles_bottom_panel.dart';
import '../../map_styles/map_styles_panel_events.dart';

class MapStylesModalBottomSheet {
  static void show(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      animationCurve: Curves.easeInOut,
      useRootNavigator: true,
      builder: (context) => const MapStylesBottomPanel(),
    ).then((val) => AppBlocs.mapStylesBloc.add(ToggleMapStylesVisibilityEvent()));
  }
}
