import 'package:data/models/landmark_entity_impl.dart';
import 'package:data/models/task_progress_listener_impl.dart';
import 'package:data/repositories_impl/extensions.dart';

import 'package:domain/entities/route_entity.dart';
import 'package:domain/repositories/route_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:domain/settings/bike_preferences_entity.dart';
import 'package:domain/utils/failures.dart';
import 'package:shared/domain/landmark_entity.dart';

import 'package:gem_kit/core.dart';
import 'package:gem_kit/routing.dart';

import 'package:dartz/dartz.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:shared/extensions.dart';

class RouteRepositoryImpl extends RouteRepository {
  @override
  TaskProgressListener route(
      {required LandmarkEntityList waypoints,
      required Function(RouteResult) onResult,
      required RoutePreferencesEntity preferences}) {
    var progressListener = TaskProgressListenerImpl();

    List<Landmark> landmarkWaypoints;
    final isFingerDrawn = waypoints.length == 1 && (waypoints.first as LandmarkEntityImpl).refList != null;

    if (isFingerDrawn) {
      landmarkWaypoints = (waypoints.first as LandmarkEntityImpl).refList!;
    } else {
      landmarkWaypoints = [];
      for (final wp in waypoints) {
        wp as LandmarkEntityImpl;
        landmarkWaypoints.add(wp.toGemLandmark());
      }
    }

    final prefs = preferences.toGemRoutePreferences();

    prefs.resultDetails = RouteResultDetails.full;

    bool isPositionBased = waypoints.any((wpt) => wpt.isPositionBased);

    try {
      progressListener.ref = RoutingService.calculateRoute(
          landmarkWaypoints,
          prefs,
          (err, result) => _routeCalculationHandler(
                err: err.code,
                result: result,
                waypoints: waypoints,
                onResult: onResult,
                progressListener: progressListener,
                isPositionBased: isPositionBased,
                isFingerDrawn: isFingerDrawn,
                isTourBased: false,
              ));
    } catch (e) {
      onResult(Left(RouteError.routeTooLong.index));
    }

    return progressListener;
  }

  @override
  void cancelRoute(TaskProgressListener listener) {
    listener as TaskProgressListenerImpl;

    listener.shouldCancel = true;
    if (listener.ref == null) return;
    RoutingService.cancelRoute(listener.ref!);
  }

  _routeCalculationHandler({
    required int err,
    required List<LandmarkEntity> waypoints,
    required List<Route>? result,
    required Function(RouteResult) onResult,
    required TaskProgressListener progressListener,
    required bool isPositionBased,
    required bool isFingerDrawn,
    required bool isTourBased,
  }) async {
    progressListener as TaskProgressListenerImpl;

    if (err != GemError.success.code || result == null) {
      onResult(Left(err));
      return;
    }

    if (progressListener.shouldCancel) return;

    final routeEntities = <RouteEntity>[];

    for (final route in result) {
      if (progressListener.shouldCancel) return;
      final routeEntity =
          route.toEntityImpl(waypoints: waypoints, isTourBased: isTourBased, isFingerDrawn: isFingerDrawn);
      routeEntities.add(routeEntity);
    }

    if (progressListener.shouldCancel) return;

    onResult(Right(routeEntities));
  }

  @override
  TaskProgressListener routeFromPath(
      {required PathEntity path,
      required Function(RouteResult p1) onResult,
      required RoutePreferencesEntity preferences}) {
    var progressListener = TaskProgressListenerImpl();
    List<Landmark> landmarkWaypoints = [];

    final prefs = preferences.toGemRoutePreferences();

    prefs.resultDetails = RouteResultDetails.full;

    final waypoints = path.coordinates.skip(50).map((e) {
      return LandmarkEntityImpl(
        ref: e.toGemLandmark(),
        isPositionBased: false,
      );
    }).toList();

    for (final wp in waypoints) {
      landmarkWaypoints.add(wp.toGemLandmark());
    }

    try {
      progressListener.ref = RoutingService.calculateRoute(landmarkWaypoints, prefs, (err, result) => _routeCalculationHandler(
          err: err.code,
          result: result,
          waypoints: waypoints,
          onResult: onResult,
          progressListener: progressListener,
          isPositionBased: true,
          isFingerDrawn: false,
          isTourBased: false,
        ));
    } catch (e) {
      onResult(Left(RouteError.routeTooLong.index));
    }

    return progressListener;
  }
}
