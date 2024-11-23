import 'package:domain/repositories/navigation_repository.dart';
import 'package:domain/use_cases/location_use_case.dart';


import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/navigation_use_case.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/navigation/navigation_view_events.dart';
import 'package:running_app/navigation/navigation_view_state.dart';

class NavigationViewBloc extends Bloc<NavigationViewEvent, NavigationViewState> {
  DateTime _lastCoordinatesTimestamp = DateTime.now();

  final NavigationUseCase _navigationUseCase;

  final LocationUseCase _locationUseCase;

  NavigationViewBloc()
      : _navigationUseCase = sl.get<NavigationUseCase>(),
        _locationUseCase = sl.get<LocationUseCase>(),
        super(const NavigationViewState()) {
    on<StartNavigationEvent>(_startNavigationEventHandler);
    on<StopNavigationEvent>(_stopNavigationEventHandler);

    on<ToggleVoiceInstructionsEvent>(_toggleVoiceInstructionsEventHandler);

    on<DialogVisibilityChangedEvent>(_dialogVisibilityChangedEventHandler);

    on<NavigationStatusUpdatedEvent>(_handleNavigationStatusUpdated);
    on<CurrentInstructionUpdatedEvent>(_currentInstructionUpdatedEventHandler);

    on<StartTimeStampUpdatedEvent>(_startTimeStampUpdatedEventHandler);
    on<EndTimeStampUpdatedEvent>(_endTimeStampUpdatedEventHandler);

    on<NavigationRouteUpdatedEvent>(_handleRouteUpdated);
    on<SetNavigationRoadBlockEvent>(_handleSetNavigationRoadBlockEvent);

    on<DestinationReachedEvent>(_destinationReachedEventHandler);

    on<ToggleSimulationEvent>(_handleToggleSimulation);

    on<AddPreviousCoordinatesEvent>(_handleAddPreviousCoordinates);
  }

  _startNavigationEventHandler(StartNavigationEvent event, Emitter<NavigationViewState> emit) async {
    emit(state.copyWith(
        route: event.route,
        traveledDistance: 0,
        isNavigatingOnTour: event.isNavigatingOnTour,
        previousCoordinates: []));

    if (state.isSimulated && (!_locationUseCase.hasPosition || !_locationUseCase.hasLocationPermission)) {
      _locationUseCase.listenLivePosition();
    }

    _navigationUseCase.startNavigation(
        route: event.route,
        isSimulated: state.isSimulated,
        onInstructionUpdated: (ins) {
          if (isClosed) return;
          add(CurrentInstructionUpdatedEvent(ins));
        },
        onWaypointReached: (wpt) {
          if (isClosed) return;
        },
        onRouteUpdated: (route) {
          if (isClosed) return;
          add(NavigationRouteUpdatedEvent(route));
        },
        onDestinationReached: () {
          if (isClosed) return;
          add(DestinationReachedEvent());
        },
        demoSpeed: 10);

    emit(state.copyWith(isNavigatingOnTour: event.isNavigatingOnTour));

    add(NavigationStatusUpdatedEvent(NavigationStatus.started));
    add(StartTimeStampUpdatedEvent(DateTime.now()));
  }

  _toggleVoiceInstructionsEventHandler(ToggleVoiceInstructionsEvent event, Emitter<NavigationViewState> emit) async {
    emit(state.copyWith(areVoiceInstructionsEnabled: !event.mute));
    await _navigationUseCase.setVoiceInstructionVolume(!event.mute ? 0.5 : 0.0);
  }

  _dialogVisibilityChangedEventHandler(DialogVisibilityChangedEvent event, Emitter<NavigationViewState> emit) {
    emit(state.copyWith(shownDialog: event.dialog));
  }

  _stopNavigationEventHandler(StopNavigationEvent event, Emitter<NavigationViewState> emit) async {
    _navigationUseCase.stopNavigation();

    await _navigationUseCase.setVoiceInstructionVolume(0.5);

    if (state.isSimulated == true &&
        (_locationUseCase.hasPosition == false || _locationUseCase.hasLocationPermission == false)) {
      _locationUseCase.cancelPositionListener();
    }
    emit(state.copyWithNullInstruction().copyWithNullRoute().copyWithNullTrip().copyWith(isNavigatingOnTour: false));
  }

  _handleNavigationStatusUpdated(NavigationStatusUpdatedEvent event, Emitter<NavigationViewState> emit) async {
    if (event.status == NavigationStatus.finished) {
      emit(state.copyWithNullRoute().copyWithNullInstruction().copyWithNullTrip());

      _navigationUseCase.setVoiceInstructionVolume(0.5);
    }

    emit(state.copyWith(status: event.status));
  }

  _currentInstructionUpdatedEventHandler(CurrentInstructionUpdatedEvent event, Emitter<NavigationViewState> emit) {
    final remainingDistance = event.instruction.remainingDistance;
    final totalDistance = state.route != null ? state.route!.distance : 0;
    final traveledDistance = totalDistance - remainingDistance;

    emit(state.copyWith(currentInstruction: event.instruction, traveledDistance: traveledDistance));
  }

  _startTimeStampUpdatedEventHandler(StartTimeStampUpdatedEvent event, Emitter<NavigationViewState> emit) {
    emit(state.copyWith(startNavigationTimeStamp: event.time));
  }

  _endTimeStampUpdatedEventHandler(EndTimeStampUpdatedEvent event, Emitter<NavigationViewState> emit) {
    emit(state.copyWith(endNavigationTimeStamp: event.time));
  }

  _handleRouteUpdated(NavigationRouteUpdatedEvent event, Emitter<NavigationViewState> emit) {
    emit(state.copyWith(route: event.route));
  }

  _handleSetNavigationRoadBlockEvent(SetNavigationRoadBlockEvent event, Emitter<NavigationViewState> emit) =>
      _navigationUseCase.setNavigationRoadBlock(length: event.length);

  _destinationReachedEventHandler(DestinationReachedEvent event, Emitter<NavigationViewState> emit) async {
    add(StopNavigationEvent());

    if (isClosed) return;
    add(NavigationStatusUpdatedEvent(NavigationStatus.finished));
    add(EndTimeStampUpdatedEvent(DateTime.now()));
  }

  _handleToggleSimulation(ToggleSimulationEvent event, Emitter<NavigationViewState> emit) =>
      emit(state.copyWith(isSimulated: !state.isSimulated));

  _handleAddPreviousCoordinates(AddPreviousCoordinatesEvent event, Emitter<NavigationViewState> emit) {
    if (DateTime.now().difference(_lastCoordinatesTimestamp).inMilliseconds <= 1000) return;
    _lastCoordinatesTimestamp = DateTime.now();

    final updatedCoords = [...state.previousCoordinates, event.coordinates];
    emit(state.copyWith(previousCoordinates: updatedCoords));
  }
}
