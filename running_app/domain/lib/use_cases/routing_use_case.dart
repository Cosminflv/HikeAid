import 'package:domain/entities/route_entity.dart';
import 'package:domain/entities/transport_means.dart';
import 'package:domain/repositories/route_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';

import 'package:dartz/dartz.dart';
import 'package:domain/settings/bike_preferences_entity.dart';
import 'dart:async';

import 'package:domain/utils/failures.dart';
import 'package:shared/domain/landmark_entity.dart';

enum RouteBuildStatus { none, building, succes, failed, canceled }

class RoutingUseCase {
  final RouteRepository _routeRepository;

  final Map<DTransportMeans, TaskProgressListener> _activeRouteCalculations = {};

  TaskProgressListener? _currentRouteProgressListener;

  RoutingUseCase(this._routeRepository);

  Future<void> buildRoute(
      {required LandmarkEntityList waypoints,
      required Function(RouteResult) onResult,
      required DTransportMeans transportMeans,
      bool isFingerDrawn = false}) async {
    cancelDurationsTo();

    final preferences = RoutePreferencesEntity(transportMeans: transportMeans);

    _currentRouteProgressListener = _routeRepository.route(
        waypoints: waypoints,
        preferences: preferences,
        onResult: (result) {
          _currentRouteProgressListener = null;
          onResult(result);
        });
  }

  void cancelRoute() {
    if (_currentRouteProgressListener != null) {
      _routeRepository.cancelRoute(_currentRouteProgressListener!);
      _currentRouteProgressListener = null;
    }
  }

  void computeDurationsTo(
      {required List<LandmarkEntity> waypoints,
      required List<DTransportMeans> transportMeans,
      required Function(DTransportMeans, Either<Failure, int>) onDistanceCalculated}) {
    for (final mode in transportMeans) {
      _getDurationTo(waypoints: waypoints, transportMeans: mode, withOnlyTimeDistance: true).then((value) {
        onDistanceCalculated(mode, value);
      });
    }
  }

  void cancelDurationsTo() {
    _activeRouteCalculations.forEach((key, value) {
      _routeRepository.cancelRoute(value);
    });
    _activeRouteCalculations.clear();
  }

  Future<Either<Failure, int>> _getDurationTo(
      {required List<LandmarkEntity> waypoints,
      required DTransportMeans transportMeans,
      bool withOnlyTimeDistance = false}) async {
    final routeCompleter = Completer<Either<Failure, int>>();

    final preferences = RoutePreferencesEntity(transportMeans: transportMeans);

    final listener = _routeRepository.route(
        waypoints: waypoints,
        preferences: preferences,
        onResult: (result) {
          _activeRouteCalculations.remove(transportMeans);

          if (result is Left) {
            routeCompleter.complete(Left(RoutingFailure()));
            return;
          }

          final routes = (result as Right).value as List<RouteEntity>;

          if (routes.isEmpty) {
            routeCompleter.complete(Left(RoutingFailure()));
            return;
          }

          routeCompleter.complete(Right(routes[0].duration));
        });

    _activeRouteCalculations[transportMeans] = listener;

    return routeCompleter.future;
  }
}
