import 'package:shared/domain/position_entity.dart';

abstract class LocationEvent {}

class InitializeLocationEvent extends LocationEvent {}

class AppResumedEvent extends LocationEvent {}

class PositionUpdatedEvent extends LocationEvent {
  PositionEntity? position;
  PositionUpdatedEvent(this.position);
}

class LocationStatusUpdatedEvent extends LocationEvent {
  final bool isEnabled;

  LocationStatusUpdatedEvent(this.isEnabled);
}

class PermissionStatusUpdatedEvent extends LocationEvent {
  bool hasPermission;

  PermissionStatusUpdatedEvent(this.hasPermission);
}

class AskForLocationPermissionEvent extends LocationEvent {}

class OpenLocationServiceEvent extends LocationEvent {}

class OpenLocationPanelEvent extends LocationEvent {}
