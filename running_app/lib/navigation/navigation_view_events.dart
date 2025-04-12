import 'package:shared/domain/coordinates_entity.dart';
import 'package:domain/entities/navigation_instruction_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/repositories/navigation_repository.dart';
import 'package:running_app/navigation/navigation_view_state.dart';

abstract class NavigationViewEvent {}

class StartNavigationEvent extends NavigationViewEvent {
  final RouteEntity route;
  final double? demoSpeedMultiplier;
  final bool isNavigatingOnTour;

  StartNavigationEvent(this.route, this.demoSpeedMultiplier, {this.isNavigatingOnTour = false});
}

class ToggleSimulationEvent extends NavigationViewEvent {}

class StopNavigationEvent extends NavigationViewEvent {
  StopNavigationEvent();
}

class DialogVisibilityChangedEvent extends NavigationViewEvent {
  final EVisibleDialog dialog;

  DialogVisibilityChangedEvent({required this.dialog});
}

class CurrentInstructionUpdatedEvent extends NavigationViewEvent {
  final NavigationInstructionEntity instruction;

  CurrentInstructionUpdatedEvent(this.instruction);
}

class ToggleVoiceInstructionsEvent extends NavigationViewEvent {
  final bool mute;

  ToggleVoiceInstructionsEvent({required this.mute});
}

class NavigationStatusUpdatedEvent extends NavigationViewEvent {
  final NavigationStatus status;

  NavigationStatusUpdatedEvent(this.status);
}

class StartTimeStampUpdatedEvent extends NavigationViewEvent {
  final DateTime time;

  StartTimeStampUpdatedEvent(this.time);
}

class EndTimeStampUpdatedEvent extends NavigationViewEvent {
  final DateTime time;

  EndTimeStampUpdatedEvent(this.time);
}

class NavigationRouteUpdatedEvent extends NavigationViewEvent {
  final RouteEntity route;

  NavigationRouteUpdatedEvent(this.route);
}

class SetNavigationRoadBlockEvent extends NavigationViewEvent {
  final int length;

  SetNavigationRoadBlockEvent(this.length);
}

class ToggleInstructionsListEvent extends NavigationViewEvent {
  ToggleInstructionsListEvent();
}

class DestinationReachedEvent extends NavigationViewEvent {
  DestinationReachedEvent();
}

class AddPreviousCoordinatesEvent extends NavigationViewEvent {
  final CoordinatesEntity coordinates;

  AddPreviousCoordinatesEvent(this.coordinates);
}
