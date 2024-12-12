import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/map_controller.dart';

import 'package:flutter/widgets.dart';

abstract class MapWidgetBuilder {
  Widget build(Function(MapController)? onMapCreated, CoordinatesEntity? coordinates, int? zoom, String? authToken);
}
