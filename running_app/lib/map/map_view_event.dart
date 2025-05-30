import 'dart:typed_data';
import 'dart:ui';

import 'package:domain/entities/alert_entity.dart';
import 'package:domain/entities/camera_state_entity.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/settings/general_settings_entity.dart';

abstract class MapViewEvent {}

class InitMapViewEvent extends MapViewEvent {
  final String? instanceName;
  final PointEntity screenCenter;
  final bool isInteractive;

  final PointEntity<double> Function() centerOfVisibleAreaFunction;
  final ViewAreaEntity Function() mapVisibleAreaFunction;

  InitMapViewEvent({
    this.instanceName,
    required this.screenCenter,
    required this.mapVisibleAreaFunction,
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

class PresentHighlightsEvent extends MapViewEvent {
  final List<LandmarkEntity> landmarks;
  final PointEntity? screenPosition;
  final bool showLabel;
  final bool isPin;
  final Uint8List? image;

  PresentHighlightsEvent({
    required this.landmarks,
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

class ClearPathsEvent extends MapViewEvent {}

class SetPositionTracker extends MapViewEvent {
  final bool visibility;
  SetPositionTracker(this.visibility);
}

class AddPolylineMarkerEvent extends MapViewEvent {
  final List<CoordinatesEntity> coordinates;

  AddPolylineMarkerEvent(this.coordinates);
}

class PresentPathEvent extends MapViewEvent {
  final PathEntity path;
  final Color? colorBorder;
  final Color? colorInner;
  final double? szBorder;
  final double? szInner;
  final ViewAreaEntity? viewArea;

  PresentPathEvent({
    required this.path,
    this.colorBorder,
    this.colorInner,
    this.szBorder,
    this.szInner,
    this.viewArea,
  });
}

class CenterOnPathEvent extends MapViewEvent {
  final PathEntity path;
  final ViewAreaEntity? viewArea;

  CenterOnPathEvent({required this.path, this.viewArea});
}

class CenterOnCoordinatesEvent extends MapViewEvent {
  final CoordinatesEntity coordinates;
  final PointEntity screenPosition;
  final int? zoomLevel;
  final bool withAnimation;
  CenterOnCoordinatesEvent({
    required this.coordinates,
    required this.screenPosition,
    this.zoomLevel,
    this.withAnimation = true,
  });
}

class SetCameraStateEvent extends MapViewEvent {
  final MapCameraStateEntity cameraState;

  SetCameraStateEvent({required this.cameraState});
}

class ClearMarkersEvent extends MapViewEvent {}

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

class CenterOnRoutesEvent extends MapViewEvent {
  final ViewAreaEntity? viewArea;
  CenterOnRoutesEvent({this.viewArea});
}

class SelectedRouteUpdatedEvent extends MapViewEvent {
  final RouteEntity route;

  SelectedRouteUpdatedEvent(this.route);
}

class PresentRoutesEvent extends MapViewEvent {
  final List<RouteEntity> routes;
  final DDistanceUnit distanceUnit;
  final ViewAreaEntity? viewArea;
  final bool hasLabel;

  final bool shouldCenter;

  PresentRoutesEvent(
      {required this.routes,
      required this.distanceUnit,
      this.viewArea,
      this.hasLabel = false,
      this.shouldCenter = true});
}

class RemoveAllRoutesEvent extends MapViewEvent {}

class RemoveRoutesEvent extends MapViewEvent {
  final List<RouteEntity> routes;
  RemoveRoutesEvent(this.routes);
}

class RemoveAllRoutesExceptEvent extends MapViewEvent {
  final List<RouteEntity> routes;

  RemoveAllRoutesExceptEvent(this.routes);
}

class RemoveRoutesExceptMainEvent extends MapViewEvent {
  RemoveRoutesExceptMainEvent();
}

class SetIsMapInteractiveEvent extends MapViewEvent {
  final bool isMapInteractive;

  SetIsMapInteractiveEvent({required this.isMapInteractive});
}

class RemoveAllHighlightsEvent extends MapViewEvent {
  final bool removeFromMap;
  final bool removeFromState;
  RemoveAllHighlightsEvent({
    this.removeFromMap = true,
    this.removeFromState = true,
  });
}

class AddAlertsEvent extends MapViewEvent {
  final List<AlertEntity> alerts;

  AddAlertsEvent({required this.alerts});
}

class SelectedAlertUpdatedEvent extends MapViewEvent {
  final CoordinatesEntity? markerCoordinate;

  SelectedAlertUpdatedEvent({required this.markerCoordinate});
}

class UnselectAlertEvent extends MapViewEvent {}

class ApplyMapStyleByPathEvent extends MapViewEvent {
  final String path;
  final bool smoothTransition;

  ApplyMapStyleByPathEvent({required this.path, required this.smoothTransition});
}
