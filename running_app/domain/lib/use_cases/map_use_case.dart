import 'dart:typed_data';

import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/repositories/camera_repository.dart';
import 'package:domain/repositories/map_repository.dart';

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
          required Function(LandmarkEntity?, RouteEntity?) onTap}) =>
      _mapRepository.registerMapGesturesCallbacks(
          onMapAngleUpdated: onMapAngleUpdated, onMapMove: onMapMove, onTap: onTap);

  MapCameraStateEntity? getCameraState() => _mapRepository.getCameraState();

  void presentHighlight(LandmarkEntity landmark, {int? highlightId, bool showLabel = true, Uint8List? image}) =>
      _mapRepository.presentHighlights(landmark, highlightId: highlightId, showLabel: showLabel, image: image);

  void removeHighlights(int highlightId) => _mapRepository.removeHighlight(highlightId);

  void presentRoutes(List<RouteEntity> routes, {bool hasLabel = true}) {
    for (final r in routes) {
      final isMain = r == routes.first;
      _mapRepository.presentRoute(r, isMainRoute: isMain, hasLabel: hasLabel);
    }
  }

  void centerOnMapRoutes(ViewAreaEntity viewArea, bool withAnimation, bool addCenterPadding) => _cameraRepository
      .centerOnMapRoutes(area: viewArea, withAnimation: withAnimation, addCenterPadding: addCenterPadding);

  void setMainRoute(RouteEntity route) => _mapRepository.setMainRoute(route);

  void removeRoute(RouteEntity route) => _mapRepository.removeRoute(route);

  void removeRoutes() => _mapRepository.clearRoutes();

  void removeRoutesExcept(List<RouteEntity> routes) => _mapRepository.clearRouteExcept(routes);

  void setFollowPositionPreferences(
          {required DFollowPositionRotationMode mode, double angle = 0, bool objectFollowMap = false}) =>
      _cameraRepository.setFollowPositionPreferences(mode: mode, angle: angle, objectFollowMap: objectFollowMap);

  void setPositionTrackerImage(Uint8List imageData, {double scale = 1.0}) =>
      _mapRepository.setPositionTrackerImage(imageData, scale: scale);

  void alignCompassNorth() => _mapRepository.alignNorthUp();

  void centerOnCoordinates({required CoordinatesEntity coordinates, required PointEntity screenPosition, int? zoom}) =>
      _cameraRepository.centerOnCoordinates(
          coordinates: coordinates, point: screenPosition, zoom: zoom, withAnimation: true);
}
