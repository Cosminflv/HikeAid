import 'package:data/utils/map_widget_builder_impl.dart';

import 'package:domain/map_widget.dart';

import 'package:gem_kit/map.dart';

import 'package:flutter/widgets.dart';
import 'package:shared/extensions.dart';

class MapWidgetImpl extends MapWidget {
  MapWidgetImpl({super.onMapCreated, super.initialCoordinates, super.zoomLevel});

  @override
  Widget build(BuildContext context) {
    return GemMap(
      key: ValueKey("MapWidget"),
      zoomLevel: zoomLevel,
      coordinates: initialCoordinates?.toGemCoordinates(),
      onMapCreated: (gemController) {
        if (super.onMapCreated == null) return;

        super.onMapCreated!(MapControllerImpl(gemController));
      },
    );
  }
}
