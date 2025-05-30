import 'dart:typed_data';
import 'dart:ui';

import 'package:domain/entities/alert_entity.dart';
import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/repositories/camera_repository.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';

class MapUseCase {
  final MapRepository _mapRepository;
  final CameraRepository _cameraRepository;

  MapUseCase(this._mapRepository, this._cameraRepository);

  void startFollowPosition({
    int zoom = 70,
    double viewAngle = 0,
    Function()? onComplete,
    required PointEntity<double> pointToCenter,
  }) =>
      _cameraRepository.startFollowPosition(
        zoom: zoom,
        viewAngle: viewAngle,
        onComplete: onComplete,
        pointToCenter: pointToCenter,
      );

  void setEnableTouchGestures(bool enable) => _mapRepository.setEnableTouchGestures(enable);

  void registerMapGestureCallbacks(
          {required Function(double) onMapAngleUpdated,
          required Function() onMapMove,
          required Function(LandmarkEntity?, RouteEntity?) onTap,
          required Function(List<CoordinatesEntity>) onMarkerSelected}) =>
      _mapRepository.registerMapGesturesCallbacks(
          onMapAngleUpdated: onMapAngleUpdated, onMapMove: onMapMove, onTap: onTap, onMarkerSelected: onMarkerSelected);

  MapCameraStateEntity? getCameraState() => _mapRepository.getCameraState();

  void applyMapStyleByPath({required String path, bool smoothTransition = true}) =>
      _mapRepository.applyMapStyleByPath(path: path, smoothTransition: smoothTransition);

  void presentHighlight(LandmarkEntity landmark, {int? highlightId, bool showLabel = true, Uint8List? image}) =>
      _mapRepository.presentHighlights(landmark, highlightId: highlightId, showLabel: showLabel, image: image);

  void removeHighlights(int highlightId) => _mapRepository.removeHighlight(highlightId);

  void presentRoutes(List<RouteEntity> routes, {bool hasLabel = true}) {
    for (final r in routes) {
      final isMain = r == routes.first;
      _mapRepository.presentRoute(r, isMainRoute: isMain, hasLabel: hasLabel);
    }
  }

  void presentPath(
      {required PathEntity path, Color? colorBorder, Color? colorInner, double? szBorder, double? szInner}) {
    _mapRepository.presentPath(
        path: path, colorBorder: colorBorder, colorInner: colorInner, szBorder: szBorder, szInner: szInner);
  }

  void clearPaths() => _mapRepository.clearPaths();

  void centerOnMapRoutes(ViewAreaEntity viewArea, bool withAnimation, bool addCenterPadding) => _cameraRepository
      .centerOnMapRoutes(area: viewArea, withAnimation: withAnimation, addCenterPadding: addCenterPadding);

  void setMainRoute(RouteEntity route) => _mapRepository.setMainRoute(route);

  void removeRoute(RouteEntity route) => _mapRepository.removeRoute(route);

  void removeRoutes() => _mapRepository.clearRoutes();

  void removeRoutesExcept(List<RouteEntity> routes) => _mapRepository.clearRouteExcept(routes);

  void clearAllButMainRoute() => _mapRepository.clearAllButMainRoute();

  void clearHighlights() => _mapRepository.clearHighlights();

  // Markers and position

  Future<void> addAlerts(List<AlertEntity> alerts) async => await _mapRepository.addAlerts(alerts);

  void addPolylineMarker({required List<CoordinatesEntity> coordinates}) =>
      _mapRepository.addPolylineMarker(coordinates: coordinates);

  void clearMarkers() => _mapRepository.clearMarkers();

  void setFollowPositionPreferences(
          {required DFollowPositionRotationMode mode, double angle = 0, bool objectFollowMap = false}) =>
      _cameraRepository.setFollowPositionPreferences(mode: mode, angle: angle, objectFollowMap: objectFollowMap);

  void setPositionTrackerImage(Uint8List imageData, {double scale = 1.0}) =>
      _mapRepository.setPositionTrackerImage(imageData, scale: scale);

  void alignCompassNorth() => _mapRepository.alignNorthUp();

  void centerOnCoordinates({required CoordinatesEntity coordinates, required PointEntity screenPosition, int? zoom}) =>
      _cameraRepository.centerOnCoordinates(
          coordinates: coordinates, point: screenPosition, zoom: zoom, withAnimation: true);

  void centerOnPath(PathEntity path, ViewAreaEntity? viewArea) =>
      _cameraRepository.centerOnPath(path: path, area: viewArea);

  Future<Uint8List?> captureImage() => _mapRepository.captureImage();
}
