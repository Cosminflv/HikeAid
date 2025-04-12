import 'package:domain/map_widget_builder.dart';
import 'package:domain/map_controller.dart';
import 'package:flutter/material.dart';

import 'package:core/di/injection_container.dart';
import 'package:shared/domain/coordinates_entity.dart';

class MapWidget extends StatelessWidget {
  final CoordinatesEntity? initialCoordinates;
  final int? zoomLevel;
  final Function(MapController)? onMapCreated;
  final bool showPlaceholder;

  const MapWidget(
      {super.key, this.onMapCreated, this.initialCoordinates, this.zoomLevel, this.showPlaceholder = false});

  @override
  Widget build(BuildContext context) {
    if (showPlaceholder == true) {
      return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
    }
    return sl.get<MapWidgetBuilder>().build(onMapCreated, initialCoordinates, zoomLevel);
  }
}

waitForAnimationToFinish(BuildContext context, VoidCallback onCompleted) {
  final route = ModalRoute.of(context);
  route?.animation?.addStatusListener((AnimationStatus status) async {
    if (status.isCompleted) {
      await Future.delayed(const Duration(milliseconds: 10));
      onCompleted();
    }
  });
}
