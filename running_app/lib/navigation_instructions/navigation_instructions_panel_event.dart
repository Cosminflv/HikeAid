import 'package:domain/entities/route_entity.dart';

abstract class NavigationInstructionPanelEvent {
  const NavigationInstructionPanelEvent();
}

class NavigationInstructionPanelUpdatedEvent extends NavigationInstructionPanelEvent {
  final RouteEntity route;

  NavigationInstructionPanelUpdatedEvent({required this.route});
}

class NavigationInstructionSelectedEvent extends NavigationInstructionPanelEvent {
  final int selectedItemIndex;

  NavigationInstructionSelectedEvent({required this.selectedItemIndex});
}

class TraveledDistanceUpdatedEvent extends NavigationInstructionPanelEvent {
  final int traveledDistance;

  TraveledDistanceUpdatedEvent(this.traveledDistance);
}

class ToggleInstructionsEvent extends NavigationInstructionPanelEvent {
  const ToggleInstructionsEvent();
}
