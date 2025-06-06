import 'dart:typed_data';
import 'dart:ui';

import 'package:domain/entities/alert_entity.dart';
import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';

abstract class MapRepository {
  // Gestures
  void registerMapGesturesCallbacks(
      {required Function() onMapMove,
      required Function(double) onMapAngleUpdated,
      required Function(LandmarkEntity?, RouteEntity?) onTap,
      required Function(List<CoordinatesEntity>) onMarkerSelected});

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
  void presentPath(
      {required PathEntity path, Color? colorBorder, Color? colorInner, double? szBorder, double? szInner});
  void clearPaths();

  // Miscellaneous
  void setPositionTrackerImage(Uint8List imageData, {double scale = 1.0});
  void alignNorthUp();

  // Styling
  void applyMapStyleByPath({required String path, bool smoothTransition = true});

  void setEnableTouchGestures(bool enable);

  Future<Uint8List?> captureImage();
}
