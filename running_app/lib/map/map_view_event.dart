import 'dart:typed_data';

import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/view_area_entity.dart';

abstract class MapViewEvent {}

class InitMapViewEvent extends MapViewEvent {
  final String? instanceName;
  final bool isInteractive;

  final PointEntity<double> Function() centerOfVisibleAreaFunction;

  InitMapViewEvent({
    this.instanceName,
    this.isInteractive = true,
    required this.centerOfVisibleAreaFunction,
  });
}

class SelectedLandmarkUpdatedEvent extends MapViewEvent {
  final LandmarkEntity? landmark;
  final bool forceCenter;

  final CoordinatesEntity? coordinates;
  final String? name;

  SelectedLandmarkUpdatedEvent({required this.landmark, this.coordinates, this.name, required this.forceCenter});
}

class PresentHighlightEvent extends MapViewEvent {
  final LandmarkEntity landmark;
  final PointEntity? screenPosition;
  final bool showLabel;
  final bool isPin;
  final Uint8List? image;

  PresentHighlightEvent({
    required this.landmark,
    this.image,
    this.screenPosition,
    this.showLabel = true,
    this.isPin = false,
  });
}

class RemoveHighlightsEvent extends MapViewEvent {
  final int highlightId;
  RemoveHighlightsEvent({required this.highlightId});
}

class FollowPositionEvent extends MapViewEvent {
  final bool shouldTiltCamera;
  final bool shouldZoomCamera;
  final bool removeHighlights;

  FollowPositionEvent({required this.shouldTiltCamera, required this.shouldZoomCamera, this.removeHighlights = true});
}

class CameraStateUpdatedEvent extends MapViewEvent {}

class CompassAlignNorthEvent extends MapViewEvent {}

class CompassAngleUpdatedEvent extends MapViewEvent {
  final double angle;
  CompassAngleUpdatedEvent(this.angle);
}

class CompassLockCameraEvent extends MapViewEvent {}

class ResetCameraEvent extends MapViewEvent {
  ResetCameraEvent();
}
