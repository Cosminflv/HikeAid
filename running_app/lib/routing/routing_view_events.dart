// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/entities/transport_means.dart';
import 'package:domain/use_cases/routing_use_case.dart';
import 'package:running_app/routing/routing_view_state.dart';
import 'package:shared/domain/path_entity.dart';

abstract class RoutingViewEvent {}

class BuildRouteEvent extends RoutingViewEvent {
  final List<LandmarkEntity> waypoints;
  final CoordinatesEntity? departureCoordinates;

  BuildRouteEvent({required this.waypoints, this.departureCoordinates});
}

class BuildRouteFromPathEvent extends RoutingViewEvent {
  final PathEntity path;

  BuildRouteFromPathEvent({required this.path});
}

class SelectedTransportModeEvent extends RoutingViewEvent {
  final DTransportMeans transport;

  SelectedTransportModeEvent(this.transport);
}

class ResetRoutingStateEvent extends RoutingViewEvent {}

class RebuildRouteEvent extends RoutingViewEvent {
  final RouteEntity route;
  final LandmarkEntity waypoint;
  final CoordinatesEntity? currentNavigationCoordinates;

  RebuildRouteEvent({
    required this.route,
    required this.waypoint,
    this.currentNavigationCoordinates,
  });
}

class CancelBuildRouteEvent extends RoutingViewEvent {}

class RouteBuildFinishedEvent extends RoutingViewEvent {
  List<RouteEntity>? routes;

  RouteBuildFinishedEvent(this.routes);
}

class RouteBuildStatusUpdatedEvent extends RoutingViewEvent {
  RouteBuildStatus status;

  RouteBuildStatusUpdatedEvent(this.status);
}

class ResetEvent extends RoutingViewEvent {}

class RouteViewStatusChangedEvent extends RoutingViewEvent {
  RouteViewStatus routeViewStatus;

  RouteViewStatusChangedEvent({required this.routeViewStatus});
}
