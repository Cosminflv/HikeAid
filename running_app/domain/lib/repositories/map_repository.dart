import 'dart:typed_data';

import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/route_entity.dart';

/// A repository interface for interacting with the map and handling various map-related operations.
///
/// The [MapRepository] provides methods to control gestures, manage routes and markers,
/// and retrieve map-related data such as camera state, center coordinates, and more.
abstract class MapRepository {
  /// Registers callback functions for handling map gestures.
  ///
  /// This allows the app to react to user gestures like map movement, angle updates,
  /// and taps on the map.
  ///
  /// - Parameters:
  ///   - [onMapMove]: A callback function invoked when the map is moved by the user.
  ///   - [onMapAngleUpdated]: A callback function invoked when the map's angle is updated,
  ///     with the new angle as a [double].
  ///   - [onTap]: A callback function invoked when the user taps on the map. It provides
  ///     an optional [LandmarkEntity] and [RouteEntity] based on the tap location.
  void registerMapGesturesCallbacks({
    required Function() onMapMove,
    required Function(double) onMapAngleUpdated,
    required Function(LandmarkEntity?, RouteEntity?) onTap,
  });

  /// Gets the center coordinates of the map.
  ///
  /// - Returns: The current [CoordinatesEntity] representing the center of the map,
  ///   or `null` if the center is not available.
  CoordinatesEntity? getCenterCoordinates();

  /// Gets the current camera state of the map.
  ///
  /// - Returns: A [MapCameraStateEntity] representing the camera state, or `null`
  ///   if no camera state is available.
  MapCameraStateEntity? getCameraState();

  /// Presents a highlight on the map for a specific [LandmarkEntity].
  ///
  /// - Parameters:
  ///   - [landmark]: The [LandmarkEntity] to be highlighted on the map.
  ///   - [highlightId]: An optional unique identifier for the highlight. If not provided,
  ///     a new ID will be generated.
  ///   - [showLabel]: A boolean flag indicating whether a label should be shown with the highlight.
  ///     Defaults to `true`.
  ///   - [image]: An optional [Uint8List] representing an image to be displayed with the highlight.
  void presentHighlights(
    LandmarkEntity landmark, {
    int? highlightId,
    bool showLabel = true,
    Uint8List? image,
  });

  /// Removes a highlight from the map.
  ///
  /// - Parameters:
  ///   - [highlightId]: The ID of the highlight to be removed.
  void removeHighlight(int highlightId);

  /// Presents a route on the map.
  ///
  /// - Parameters:
  ///   - [route]: The [RouteEntity] to be displayed on the map.
  ///   - [isMainRoute]: A boolean indicating whether this route is the main route. Defaults to `false`.
  ///   - [hasLabel]: A boolean indicating whether the route should display a label. Defaults to `true`.
  ///   - [color]: An optional tuple of 3 integers representing the RGB color of the route.
  void presentRoute(
    RouteEntity route, {
    bool isMainRoute = false,
    bool hasLabel = true,
    (int, int, int)? color,
  });

  /// Presents a summary of a route on the map.
  ///
  /// - Parameters:
  ///   - [route]: The [RouteEntity] whose summary is to be presented.
  void presentRouteSummary(RouteEntity route);

  /// Sets the specified [route] as the main route on the map.
  ///
  /// - Parameters:
  ///   - [route]: The [RouteEntity] to be set as the main route.
  void setMainRoute(RouteEntity route);

  /// Clears all highlights from the map.
  ///
  /// - Returns: None.
  void clearHighlights();

  /// Clears all routes from the map, except the main route.
  ///
  /// - Returns: None.
  void clearAllButMainRoute();

  /// Clears all routes from the map.
  ///
  /// - Returns: None.
  void clearRoutes();

  /// Removes a specific route from the map.
  ///
  /// - Parameters:
  ///   - [route]: The [RouteEntity] to be removed.
  void removeRoute(RouteEntity route);

  /// Clears all routes except those in the provided [routes] list.
  ///
  /// - Parameters:
  ///   - [routes]: A list of [RouteEntity] objects to keep on the map.
  void clearRouteExcept(List<RouteEntity> routes);

  /// Adds a marker to the map at the specified [coordinates].
  ///
  /// - Parameters:
  ///   - [coordinates]: The [CoordinatesEntity] where the marker should be placed.
  ///   - [image]: The image (in [Uint8List] format) to be used as the marker's icon.
  void addMarker({
    required CoordinatesEntity coordinates,
    required Uint8List image,
  });

  /// Adds a polyline marker to the map using a list of [coordinates].
  ///
  /// - Parameters:
  ///   - [coordinates]: A list of [CoordinatesEntity] objects representing the polyline's path.
  void addPolylineMarker({required List<CoordinatesEntity> coordinates});

  /// Clears all markers from the map.
  ///
  /// - Returns: None.
  void clearMarkers();

  /// Clears all paths on the map.
  ///
  /// - Returns: None.
  void clearPaths();

  /// Sets the image used for the position tracker.
  ///
  /// - Parameters:
  ///   - [imageData]: The image data (in [Uint8List] format) to be used for the position tracker.
  ///   - [scale]: An optional scale factor for the image. Defaults to `1.0`.
  void setPositionTrackerImage(Uint8List imageData, {double scale = 1.0});

  /// Aligns the map to have the north at the top of the screen.
  ///
  /// - Returns: None.
  void alignNorthUp();

  /// Enables or disables touch gestures on the map.
  ///
  /// - Parameters:
  ///   - [enable]: A boolean flag indicating whether touch gestures should be enabled (`true`)
  ///     or disabled (`false`).
  void setEnableTouchGestures(bool enable);

  /// Captures an image of the current map view.
  ///
  /// - Returns: A [Future<Uint8List?>] that resolves to an image in [Uint8List] format,
  ///   or `null` if capturing the image fails.
  Future<Uint8List?> captureImage();
}
