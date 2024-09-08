import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/map_widget_builder.dart';
import 'package:domain/map_controller.dart';
import 'package:flutter/widgets.dart';

import 'package:core/di/injection_container.dart';

class MapWidget extends StatelessWidget {
  final CoordinatesEntity? initialCoordinates;
  final int? zoomLevel;
  final Function(MapController)? onMapCreated;

  const MapWidget({super.key, this.onMapCreated, this.initialCoordinates, this.zoomLevel});

  @override
  Widget build(BuildContext context) => sl.get<MapWidgetBuilder>().build(onMapCreated, initialCoordinates, zoomLevel);
}
