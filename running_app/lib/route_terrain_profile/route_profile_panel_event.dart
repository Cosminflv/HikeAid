import 'package:domain/entities/route_entity.dart';
import 'package:shared/domain/sections/base_section_entity.dart';

abstract class RouteProfilePanelEvent {
  const RouteProfilePanelEvent();
}

class UpdatePanelOpenStatusEvent extends RouteProfilePanelEvent {
  final bool value;

  UpdatePanelOpenStatusEvent(this.value);
}

class RouteUpdatedEvent extends RouteProfilePanelEvent {
  final RouteEntity? route;

  RouteUpdatedEvent({required this.route});
}

class DistanceSelectedEvent extends RouteProfilePanelEvent {
  final int distance;

  DistanceSelectedEvent({required this.distance});
}

class PathByDistancesSelectedEvent extends RouteProfilePanelEvent {
  final int start;
  final int end;

  PathByDistancesSelectedEvent({required this.start, required this.end});
}

class PathBySectionPresentedEvent<E> extends RouteProfilePanelEvent {
  BaseSectionEntity<E> section;
  (int, int, int) color;

  PathBySectionPresentedEvent({required this.section, required this.color});
}
