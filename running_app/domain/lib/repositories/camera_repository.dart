import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/path_entity.dart';
import 'package:domain/entities/view_area_entity.dart';

enum DFollowPositionStatus { entered, exited }

enum DFollowPositionRotationMode { positionHeading, compass, fixed }

/// A repository interface for managing camera behavior and movement on a map or navigation view.
///
/// The [CameraRepository] provides methods to control camera movement, follow position updates,
/// and center the camera on coordinates, paths, or routes. It also allows customization of camera
/// settings such as zoom and rotation preferences.
abstract class CameraRepository {
  /// Registers a callback function to be notified when the position-following status changes.
  ///
  /// This method listens for updates on whether the camera has entered or exited a position-following state.
  /// The provided callback is called with a [DFollowPositionStatus] indicating whether the camera
  /// has entered or exited the follow position mode.
  ///
  /// - Parameters:
  ///   - [onStatusUpdated]: A callback function that is called when the position-following status changes.
  ///     It receives a [DFollowPositionStatus] indicating the status update (either `entered` or `exited`).
  void registerFollowPositionStateUpdatedCallback(Function(DFollowPositionStatus) onStatusUpdated);

  // Camera Movement Methods

  /// Starts the camera following a specific position on the map.
  ///
  /// This method enables the camera to follow a specified position, updating the view as the position changes.
  /// The camera will move to the given position and center on it. Optionally, the view angle, zoom level, and
  /// completion callback can be set.
  ///
  /// - Parameters:
  ///   - [viewAngle]: The initial view angle (in degrees) of the camera. Defaults to `0`.
  ///   - [zoom]: The zoom level to apply. Defaults to `70` (medium zoom level).
  ///   - [onComplete]: An optional callback to be called when the camera movement is complete.
  ///   - [pointToCenter]: The [PointEntity] indicating the coordinates the camera should center on.
  void startFollowPosition({
    double viewAngle = 0,
    int zoom = 70,
    Function()? onComplete,
    required PointEntity<double> pointToCenter,
  });

  /// Sets preferences for the camera’s position-following behavior, including rotation mode.
  ///
  /// This method allows customization of how the camera follows the position, such as whether to rotate
  /// based on the position's heading, compass, or use a fixed rotation. Additional settings for angle and
  /// object-following behavior can also be specified.
  ///
  /// - Parameters:
  ///   - [mode]: The [DFollowPositionRotationMode] specifying the camera's rotation mode.
  ///   - [angle]: The rotation angle of the camera. Defaults to `0`.
  ///   - [objectFollowMap]: A boolean flag indicating whether the object should follow the map. Defaults to `false`.
  void setFollowPositionPreferences({
    required DFollowPositionRotationMode mode,
    double angle = 0,
    bool objectFollowMap = false,
  });

  /// Centers the camera on specific coordinates, adjusting the view angle and zoom level.
  ///
  /// This method moves the camera to center on the provided coordinates. Optionally, the view angle, zoom level,
  /// and animation behavior can be specified. If animation is enabled, the camera movement will be smoothly animated.
  ///
  /// - Parameters:
  ///   - [coordinates]: The [CoordinatesEntity] representing the geographic location to center the camera on.
  ///   - [point]: The [PointEntity] used to define the exact point on the map to center the camera on.
  ///   - [viewAngle]: The desired view angle of the camera. Defaults to `0`.
  ///   - [zoom]: An optional zoom level to apply. If not provided, the default zoom level is used.
  ///   - [withAnimation]: A boolean flag indicating whether the camera movement should be animated. Defaults to `true`.
  void centerOnCoordinates({
    required CoordinatesEntity coordinates,
    required PointEntity point,
    double viewAngle = 0,
    int? zoom,
    bool withAnimation = true,
  });

  /// Centers the camera on a path, optionally defining a specific view area.
  ///
  /// This method moves the camera to follow a given path. Optionally, a [ViewAreaEntity] can be provided to
  /// specify a particular area within which the path should be viewed.
  ///
  /// - Parameters:
  ///   - [path]: The [PathEntity] representing the path to center the camera on.
  ///   - [area]: An optional [ViewAreaEntity] to define a specific area to center on. If not provided, the whole path is used.
  void centerOnPath({required PathEntity path, ViewAreaEntity? area});

  /// Centers the camera on one or more map routes within a defined view area.
  ///
  /// This method centers the camera on one or more routes. The camera's movement and zoom behavior can be
  /// customized, and the option to add padding to the center of the view is also available.
  ///
  /// - Parameters:
  ///   - [area]: The [ViewAreaEntity] specifying the area to be viewed during route centering.
  ///   - [withAnimation]: A boolean flag indicating whether the camera movement should be animated.
  ///   - [addCenterPadding]: A boolean flag to add padding to the center of the camera's view.
  void centerOnMapRoutes({
    required ViewAreaEntity area,
    required bool withAnimation,
    required bool addCenterPadding,
  });
}
