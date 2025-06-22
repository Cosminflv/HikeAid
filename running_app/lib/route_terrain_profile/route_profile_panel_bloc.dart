import 'dart:math';

import 'package:shared/domain/path_entity.dart';
import 'package:shared/domain/sections/base_section_entity.dart';
import 'package:shared/domain/sections/road_section_entity.dart';
import 'package:shared/domain/sections/steep_section_entity.dart';
import 'package:shared/domain/sections/surface_section_entity.dart';

import 'route_profile_panel_event.dart';
import 'route_profile_panel_state.dart';

import 'package:domain/entities/route_entity.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RouteProfilePanelBloc extends Bloc<RouteProfilePanelEvent, RouteProfilePanelState> {
  RouteEntity? _route;

  RouteProfilePanelBloc() : super(const RouteProfilePanelState()) {
    on<UpdatePanelOpenStatusEvent>(_handleUpdatePanelOpenStatus);
    on<RouteUpdatedEvent>(_routeSetEventHandler);
    on<DistanceSelectedEvent>(_distanceSelectedEventHandler);
    on<PathByDistancesSelectedEvent>(_pathByDistancesSelectedEventHandler);
    on<PathBySectionPresentedEvent>(_pathBySectionPresentedEventHandler);
  }

  _handleUpdatePanelOpenStatus(UpdatePanelOpenStatusEvent event, Emitter<RouteProfilePanelState> emit) =>
      emit(state.copyWith(isOpened: event.value));

  _routeSetEventHandler(RouteUpdatedEvent event, Emitter<RouteProfilePanelState> emit) {
    _route = event.route;
    if (event.route != null) {
      emit(RouteProfilePanelState(
          terrainProfile: event.route!.terrainProfile,
          isOpened: state.isOpened,
          totalDown: _route!.totalDown,
          totalUp: _route!.totalDown));
    } else {
      emit(const RouteProfilePanelState());
    }
  }

  _distanceSelectedEventHandler(DistanceSelectedEvent event, Emitter<RouteProfilePanelState> emit) {
    if (_route == null) return;
    final markerCoordinates = _route!.getCoordinatesAtDistance(event.distance);
    emit(state.copyWith(
      markerCoordinates: markerCoordinates,
      selectedDistance: event.distance,
    ));
  }

  _pathByDistancesSelectedEventHandler(PathByDistancesSelectedEvent event, Emitter<RouteProfilePanelState> emit) {
    if (_route == null) return;

    int start = event.start;
    int end = event.end;

    // End might be after route lenght
    start = max(0, start);
    end = min(_route!.distance, end);

    emit(state.copyWith(startDistance: start, endDistance: end));
  }

  _pathBySectionPresentedEventHandler(PathBySectionPresentedEvent event, Emitter<RouteProfilePanelState> emit) {
    if (_route == null || event.section == state.currentSection) return;

    final paths = _getPathsBySectionType(_route!, event.section);

    emit(state.copyWith(pathsToPresent: paths, presentColor: event.color, currentSection: event.section));
  }

  PathEntityList _getPathsBySectionType<E>(RouteEntity route, BaseSectionEntity<E> section) {
    if (section is RoadSectionEntity) {
      return route.getPathsByRoadType(section.type as DRoadType);
    }
    if (section is SteepSectionEntity) {
      return route.getPathsBySteepness(section.type as DSteepness);
    }
    if (section is SurfaceSectionEntity) {
      return route.getPathsSurfaceType(section.type as DSurfaceType);
    }

    throw Exception("Unknown section type enum ${E.runtimeType}");
  }
}
