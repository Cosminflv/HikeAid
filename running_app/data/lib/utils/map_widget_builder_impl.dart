import 'package:data/utils/map_widget_impl.dart';
import 'package:domain/map_controller.dart';
import 'package:domain/map_widget_builder.dart';

import 'package:gem_kit/map.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:shared/domain/coordinates_entity.dart';

class MapControllerImpl extends MapController {
  final GemMapController ref;
  MapControllerImpl(this.ref);
}

class MapWidgetBuilderImpl extends MapWidgetBuilder {
  @override
  Widget build(Function(MapController)? onMapCreated, CoordinatesEntity? coordinates, int? zoom) {
    return MapWidgetImpl(
      onMapCreated: onMapCreated,
      initialCoordinates: coordinates,
      zoomLevel: zoom,
    );
  }
}
