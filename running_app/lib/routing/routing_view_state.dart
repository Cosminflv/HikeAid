import 'package:domain/entities/route_entity.dart';
import 'package:domain/use_cases/routing_use_case.dart';

import 'package:equatable/equatable.dart';

enum RouteViewStatus { none, routeDescription, routeProfile }

class RoutingViewState extends Equatable {
  final List<RouteEntity> routes;
  final RouteBuildStatus status;
  final RouteViewStatus routeViewStatus;
  final String? destinationName;

  const RoutingViewState(
      {this.routes = const [],
      this.status = RouteBuildStatus.none,
      this.routeViewStatus = RouteViewStatus.none,
      this.destinationName});

  RoutingViewState copyWith({
    List<RouteEntity>? routes,
    RouteEntity? mainRoute,
    RouteBuildStatus? status,
    RouteViewStatus? routeViewStatus,
    String? destinationName,
  }) =>
      RoutingViewState(
        routes: routes ?? this.routes,
        status: status ?? this.status,
        routeViewStatus: routeViewStatus ?? this.routeViewStatus,
        destinationName: destinationName ?? this.destinationName,
      );

  RoutingViewState copyWithNullDestinationName() =>
      RoutingViewState(routes: routes, status: status, routeViewStatus: routeViewStatus, destinationName: null);

  @override
  List<Object?> get props => [routes, status, routeViewStatus, destinationName];
}
