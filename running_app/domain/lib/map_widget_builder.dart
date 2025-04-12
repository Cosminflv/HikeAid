import 'package:domain/map_controller.dart';

import 'package:flutter/widgets.dart';
import 'package:shared/domain/coordinates_entity.dart';

abstract class MapWidgetBuilder {
  Widget build(Function(MapController)? onMapCreated, CoordinatesEntity? coordinates, int? zoom);
}
