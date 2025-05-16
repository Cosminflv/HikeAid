import 'package:domain/entities/route_entity.dart';
import 'package:domain/entities/trip_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';

import 'package:dartz/dartz.dart';
import 'package:domain/settings/bike_preferences_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';

typedef RouteResult = Either<int, List<RouteEntity>>;
typedef TripResult = Either<int, TripEntity>;

abstract class RouteRepository {
  TaskProgressListener route({
    required LandmarkEntityList waypoints,
    required Function(RouteResult) onResult,
    required RoutePreferencesEntity preferences,
  });

  TaskProgressListener routeFromPath({
    required PathEntity path,
    required Function(RouteResult) onResult,
    required RoutePreferencesEntity preferences,
  });

  void cancelRoute(TaskProgressListener listener);
}
