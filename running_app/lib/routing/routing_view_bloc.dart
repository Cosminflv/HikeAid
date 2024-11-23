import 'package:core/di/injection_container.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/use_cases/landmark_use_case.dart';
import 'package:domain/use_cases/routing_use_case.dart';
import 'package:domain/utils/failures.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:running_app/routing/routing_view_events.dart';
import 'package:running_app/routing/routing_view_state.dart';

class RoutingViewBloc extends Bloc<RoutingViewEvent, RoutingViewState> {
  final RoutingUseCase _routingUseCase;
  final LandmarkUseCase _landmarkUseCase;

  RoutingViewBloc()
      : _routingUseCase = sl.get<RoutingUseCase>(),
        _landmarkUseCase = sl.get<LandmarkUseCase>(),
        super(const RoutingViewState()) {
    on<BuildRouteEvent>(_handleBuildRoute);
    on<BuildFingerRouteEvent>(_handleBuildFingerRoute);
    on<RebuildRouteEvent>(_handleRebuildRoute);

    on<CancelBuildRouteEvent>(_handleCancelBuildRoute);

    on<ResetEvent>(_handleReset);

    on<RouteBuildFinishedEvent>(_handleRouteBuildFinished);
    on<RouteBuildStatusUpdatedEvent>(_handleRouteBuildStatusUpdated);

    on<RouteViewStatusChangedEvent>(_handleRouteViewStatusChangedEvent);
  }

  _handleBuildRoute(BuildRouteEvent event, Emitter<RoutingViewState> emit) async {
    if (event.waypoints.isEmpty) return;
    var waypoints = event.waypoints;

    if (event.departureCoordinates != null) {
      final departure = _landmarkUseCase.getLandmarkAtCoordinates(
          coordinates: event.departureCoordinates!, name: 'My Position', isPositionBased: true);

      waypoints.insert(0, departure);
    }
    if (isClosed) return;

    add(RouteBuildStatusUpdatedEvent(RouteBuildStatus.building));

    emit(state.copyWith(destinationName: event.waypoints.last.name));

    await _routingUseCase.buildRoute(
        waypoints: waypoints,
        onResult: (result) {
          if (isClosed) return;

          if (result is Left) {
            if (getRouteErrorFromGemError((result as Left).value) == RouteError.canceled) return;
            add(RouteBuildFinishedEvent(null));
          } else {
            final routes = (result as Right).value;
            add(RouteBuildFinishedEvent(routes));
          }
        });
  }

  _handleBuildFingerRoute(BuildFingerRouteEvent event, Emitter<RoutingViewState> emit) async {
    add(RouteBuildStatusUpdatedEvent(RouteBuildStatus.building));

    await _routingUseCase.buildRoute(
        waypoints: [event.marker],
        isFingerDrawn: true,
        onResult: (result) {
          if (isClosed) return;
          if (result is Left) {
            add(RouteBuildFinishedEvent(null));
          } else {
            final routes = (result as Right).value;
            add(RouteBuildFinishedEvent(routes));
          }
        });
  }

  _handleRebuildRoute(RebuildRouteEvent event, Emitter<RoutingViewState> emit) async {
    if (event.currentNavigationCoordinates != null) {
      await event.route.updateWaypoints(event.currentNavigationCoordinates!);
    }

    if (isClosed) return;

    List<LandmarkEntity> newRouteWaypoints = List.from(event.route.getWaypoints());
    newRouteWaypoints.insert(newRouteWaypoints.length - 1, event.waypoint);

    add(BuildRouteEvent(waypoints: newRouteWaypoints));
  }

  _handleCancelBuildRoute(CancelBuildRouteEvent event, Emitter<RoutingViewState> emit) {
    if (state.status == RouteBuildStatus.building) {
      _routingUseCase.cancelRoute();
      add(RouteBuildStatusUpdatedEvent(RouteBuildStatus.canceled));
    }

    emit(state.copyWith(status: RouteBuildStatus.none, routeViewStatus: RouteViewStatus.none, routes: []));
  }

  _handleReset(ResetEvent event, Emitter<RoutingViewState> emit) => emit(const RoutingViewState());

  _handleRouteBuildFinished(RouteBuildFinishedEvent event, Emitter<RoutingViewState> emit) {
    if (state.status == RouteBuildStatus.canceled) return;

    final routes = event.routes;

    if (routes == null) {
      emit(state.copyWith(routes: []));
      add(RouteBuildStatusUpdatedEvent(RouteBuildStatus.failed));
      return;
    }

    add(RouteBuildStatusUpdatedEvent(RouteBuildStatus.succes));
    emit(state.copyWith(routes: routes, mainRoute: routes.first));
  }

  _handleRouteBuildStatusUpdated(RouteBuildStatusUpdatedEvent event, Emitter<RoutingViewState> emit) =>
      emit(state.copyWith(status: event.status));

  _handleRouteViewStatusChangedEvent(RouteViewStatusChangedEvent event, Emitter<RoutingViewState> emit) =>
      emit(state.copyWith(routeViewStatus: event.routeViewStatus));
}
