import 'dart:typed_data';

import 'package:domain/entities/alert_entity.dart';
import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/route_entity.dart';

abstract class MapRepository {
  // Gestures
  void registerMapGesturesCallbacks({
    required Function() onMapMove,
    required Function(double) onMapAngleUpdated,
    required Function(LandmarkEntity?, RouteEntity?) onTap,
  });

  // Center and Distance
  CoordinatesEntity? getCenterCoordinates();
  MapCameraStateEntity? getCameraState();

  void presentHighlights(LandmarkEntity landmark, {int? highlightId, bool showLabel = true, Uint8List? image});

  // Routes
  void removeHighlight(int highlightId);
  void presentRoute(RouteEntity route, {bool isMainRoute = false, bool hasLabel = true, (int, int, int)? color});
  void presentRouteSummary(RouteEntity route);
  void setMainRoute(RouteEntity route);
  void clearHighlights();
  void clearAllButMainRoute();
  void clearRoutes();
  void removeRoute(RouteEntity route);
  void clearRouteExcept(List<RouteEntity> routes);

  // Markers
  Future<void> addAlerts(List<AlertEntity> alerts);
  void addPolylineMarker({required List<CoordinatesEntity> coordinates});
  void clearMarkers();

  // Path
  void clearPaths();

  // Miscellaneous
  void setPositionTrackerImage(Uint8List imageData, {double scale = 1.0});
  void alignNorthUp();

  void setEnableTouchGestures(bool enable);

  Future<Uint8List?> captureImage();
}
