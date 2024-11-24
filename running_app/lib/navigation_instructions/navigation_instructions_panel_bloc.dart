import 'package:domain/entities/route_instruction_description_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/navigation_instructions/navigation_instructions_panel_event.dart';
import 'package:running_app/navigation_instructions/navigation_instructions_panel_state.dart';

class NavigationInstructionPanelBloc extends Bloc<NavigationInstructionPanelEvent, NavigationInstructionPanelState> {
  NavigationInstructionPanelBloc() : super(const NavigationInstructionPanelState()) {
    on<NavigationInstructionPanelUpdatedEvent>(_routeSetEventHandler);
    on<NavigationInstructionSelectedEvent>(_routeInstructionSelectedEventHandler);
    on<ToggleInstructionsEvent>(_toggleInstructionsEventHandler);
    on<TraveledDistanceUpdatedEvent>(_traveledDistanceUpdatedEventHandler);
  }

  _routeSetEventHandler(
      NavigationInstructionPanelUpdatedEvent event, Emitter<NavigationInstructionPanelState> emit) async {
    emit(const NavigationInstructionPanelState(instructions: null));

    final routeHash = event.route.hashCode;
    await for (var newInstruction in event.route.getInstructions()) {
      if (routeHash != event.route.hashCode) {
        break;
      }
      List<RouteInstructionDescriptionEntity> instructions = [...(state.instructions ?? [])];
      instructions.add(newInstruction);
      if (isClosed) return;
      emit(NavigationInstructionPanelState(instructions: instructions, selectedItemIndex: state.selectedItemIndex));
    }
  }

  _routeInstructionSelectedEventHandler(
    NavigationInstructionSelectedEvent event,
    Emitter<NavigationInstructionPanelState> emit,
  ) async {
    int index = event.selectedItemIndex;

    emit(state.copyWith(selectedItemIndex: index));
  }

  _toggleInstructionsEventHandler(ToggleInstructionsEvent event, Emitter<NavigationInstructionPanelState> emit) {
    state.isInstructionListVisible
        ? emit(state.copyWith(isInstructionListVisible: false))
        : emit(state.copyWith(isInstructionListVisible: true));
  }

  _traveledDistanceUpdatedEventHandler(
      TraveledDistanceUpdatedEvent event, Emitter<NavigationInstructionPanelState> emit) {
    int index = 0;
    if (state.instructions == null) return;

    while (state.instructions!.isNotEmpty &&
        index < state.instructions!.length &&
        state.instructions![index].distance < event.traveledDistance) {
      index++;
    }

    final newIns = state.instructions!.sublist(index);
    final newIndex = state.selectedItemIndex - index;

    emit(state.copyWith(instructions: newIns, selectedItemIndex: newIndex < 0 ? -1 : newIndex));
  }
}
