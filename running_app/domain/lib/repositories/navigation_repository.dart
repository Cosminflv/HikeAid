import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/navigation_instruction_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';

/// Represents the current status of a navigation session.
///
/// The [NavigationStatus] enum defines various states of the navigation process.
enum NavigationStatus {
  /// Navigation has started and is currently active.
  started,

  /// Navigation has been stopped by the user or system.
  stopped,

  /// Navigation has successfully reached its final destination.
  finished,

  /// Navigation is temporarily paused.
  paused,

  /// Navigation is restarting after a pause or interruption.
  restarting,
}

/// A repository interface for managing navigation sessions and interactions.
///
/// The `NavigationRepository` provides methods to control navigation, handle roadblocks,
/// and monitor progress through various callbacks.
abstract class NavigationRepository {
  /// Starts a navigation session for the specified [route].
  ///
  /// - Parameters:
  ///   - [route]: The [RouteEntity] object representing the route to be navigated.
  ///   - [onInstructionUpdated]: A callback invoked with updated [NavigationInstructionEntity]
  ///     whenever new navigation instructions are available.
  ///   - [onVoiceInstructionUpdated]: A callback invoked with a [String] containing
  ///     voice instructions as they are generated.
  ///   - [onRouteUpdated]: A callback invoked with an updated [RouteEntity] when the route changes.
  ///   - [onWaypointReached]: A callback invoked with a [LandmarkEntity] representing a
  ///     reached waypoint.
  ///   - [onDestinationReached]: A callback invoked when the final destination is reached.
  ///   - [isSimulated]: A [bool] indicating whether the navigation session is simulated.
  ///     Defaults to `false`.
  ///   - [demoSpeed]: An optional [double] representing the simulation speed if [isSimulated] is `true`.
  /// - Returns: A [TaskProgressListener] object that monitors the progress of the navigation session.
  /// - Throws:
  ///   - [NavigationException] if the navigation session cannot be started due to route issues,
  ///     permission errors, or other conditions.
  TaskProgressListener startNavigation(
    RouteEntity route, {
    required Function(NavigationInstructionEntity) onInstructionUpdated,
    required Function(String) onVoiceInstructionUpdated,
    required Function(RouteEntity) onRouteUpdated,
    required Function(LandmarkEntity) onWaypointReached,
    required Function() onDestinationReached,
    bool isSimulated = false,
    double? demoSpeed,
  });

  /// Stops an active navigation session.
  ///
  /// - Parameters:
  ///   - [listener]: The [TaskProgressListener] associated with the navigation session to stop.
  /// - Throws:
  ///   - [NavigationException] if the navigation session cannot be stopped or
  ///     if the listener is invalid.
  void stopNavigation(TaskProgressListener listener);

  /// Sets a roadblock along the current navigation route.
  ///
  /// - Parameters:
  ///   - [progressListener]: The [TaskProgressListener] associated with the navigation session.
  ///   - [length]: The length of the roadblock in meters.
  ///   - [startDistance]: An optional [int] specifying the distance from the current location
  ///     where the roadblock begins. If omitted, the roadblock starts immediately.
  /// - Throws:
  ///   - [NavigationException] if the roadblock cannot be set due to invalid parameters
  ///     or system constraints.
  void setNavigationRoadBlock({
    required TaskProgressListener progressListener,
    required int length,
    int? startDistance,
  });
}
