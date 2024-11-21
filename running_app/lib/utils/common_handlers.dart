import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:running_app/map/map_view_event.dart';

void handleSearchOrPlanningResult(Object? result, BuildContext context, {bool isRoutePlanning = false}) {
  final mapBloc = AppBlocs.mapBloc;
  if (result is LandmarkEntity) {
    mapBloc.add(SelectedLandmarkUpdatedEvent(landmark: result, forceCenter: true));
    if (isRoutePlanning) {
      Navigator.of(context).pop(result);
    }
  }
}
