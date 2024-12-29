import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/entities/trip_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';

import 'package:dartz/dartz.dart';
import 'package:domain/settings/bike_preferences_entity.dart';

/// A repository interface for managing route generation and operations.
///
/// This repository provides methods to calculate routes based on specified waypoints
/// and user preferences. It also supports cancellation of ongoing route calculations.
abstract class RouteRepository {
  /// Calculates a route based on the given [waypoints] and [preferences].
  ///
  /// - Parameters:
  ///   - [waypoints]: A [LandmarkEntityList] representing the points that define the route.
  ///     These may include a starting point, intermediate stops, and a destination.
  ///   - [onResult]: A callback function invoked with the [RouteResult] once the route
  ///     calculation is complete. The [RouteResult] is:
  ///     - `Left<int>`: An error code if the route calculation fails.
  ///     - `Right<List<RouteEntity>>`: A list of calculated routes if successful.
  ///   - [preferences]: A [RoutePreferencesEntity] specifying user preferences such as
  ///     travel mode, route type (e.g., shortest, fastest), or other customization options.
  /// - Returns: A [TaskProgressListener] that can be used to monitor or cancel the
  ///   route calculation operation.
  /// - Throws:
  ///   - [SomeSpecificException] if the operation fails due to connectivity, validation,
  ///     or other issues.
  TaskProgressListener route({
    required LandmarkEntityList waypoints,
    required Function(RouteResult) onResult,
    required RoutePreferencesEntity preferences,
  });

  /// Cancels an ongoing route calculation operation identified by the [listener].
  ///
  /// - Parameters:
  ///   - [listener]: A [TaskProgressListener] associated with the ongoing route calculation.
  /// - Throws:
  ///   - [SomeSpecificException] if the cancellation fails or the listener is invalid.
  void cancelRoute(TaskProgressListener listener);
}

/// A type alias for route results.
///
/// - `Left<int>`: Represents an error code in case of a failure.
/// - `Right<List<RouteEntity>>`: Contains a list of routes if the operation is successful.
typedef RouteResult = Either<int, List<RouteEntity>>;

/// A type alias for trip results.
///
/// - `Left<int>`: Represents an error code in case of a failure.
/// - `Right<TripEntity>`: Contains a [TripEntity] if the operation is successful.
typedef TripResult = Either<int, TripEntity>;
