import 'package:core/di/injection_container.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/use_cases/location_use_case.dart';
import 'package:domain/use_cases/landmark_use_case.dart';
import 'package:running_app/location/location_event.dart';
import 'package:running_app/location/location_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationUseCase _locationUseCase;
  final LandmarkUseCase _landmarkUseCase;

  late StreamSubscription _permissionStreamSubscription;
  late StreamSubscription _positionStreamSubscription;
  late StreamSubscription _locationStatusStreamSubscription;

  LocationBloc()
      : _locationUseCase = sl.get<LocationUseCase>(),
        _landmarkUseCase = sl.get<LandmarkUseCase>(),
        super(const LocationState()) {
    on<InitializeLocationEvent>(_handleInitializeLocation);
    on<AppResumedEvent>(_handleAppResumed);

    on<PositionUpdatedEvent>(_handlePositionUpdated);

    on<PermissionStatusUpdatedEvent>(_handlePermissionStatusUpdated);
    on<LocationStatusUpdatedEvent>(_handleLocationStatusUpdated);

    on<AskForLocationPermissionEvent>(_handleAskForLocationPermission);
    on<OpenLocationServiceEvent>(_handleOpenLocationService);
    on<OpenLocationPanelEvent>(_handleOpenLocationPanel);
  }

  _handleInitializeLocation(InitializeLocationEvent event, Emitter<LocationState> emit) {
    _locationUseCase.initialize();

    _positionStreamSubscription = _locationUseCase.positionStream.listen((position) {
      if (isClosed) return;
      add(PositionUpdatedEvent(position));
    });

    _permissionStreamSubscription = _locationUseCase.locationStatusStream.listen((isEnabled) {
      if (isClosed) return;
      add(LocationStatusUpdatedEvent(isEnabled));
    });

    _locationStatusStreamSubscription = _locationUseCase.locationPermissionStream.listen((isEnabled) {
      if (isClosed) return;
      add(PermissionStatusUpdatedEvent(isEnabled));
    });
  }

  _handleAppResumed(AppResumedEvent event, Emitter<LocationState> emit) async =>
      await _locationUseCase.updatePermissionsStatus();

  _handlePositionUpdated(PositionUpdatedEvent event, Emitter<LocationState> emit) {
    if (event.position == null) {
      emit(state.copyWithNullPosition());
    } else {
      emit(state.copyWith(currentPosition: event.position));
    }
  }

  _handlePermissionStatusUpdated(PermissionStatusUpdatedEvent event, Emitter<LocationState> emit) {
    emit(state.copyWith(hasLocationPermission: event.hasPermission));
    if (event.hasPermission == false) {
      emit(state.copyWith(openLocationPanel: false));
    }
  }

  _handleLocationStatusUpdated(LocationStatusUpdatedEvent event, Emitter<LocationState> emit) =>
      emit(state.copyWith(isLocationEnabled: event.isEnabled));

  _handleAskForLocationPermission(AskForLocationPermissionEvent event, Emitter<LocationState> emit) async {
    final hasGrantedPermission = await _locationUseCase.askLocationPermission();
    if (isClosed) return;

    emit(state.copyWith(hasLocationPermission: hasGrantedPermission));
  }

  _handleOpenLocationService(OpenLocationServiceEvent event, Emitter<LocationState> emit) async {
    await _locationUseCase.openLocationService();
  }

  _handleOpenLocationPanel(OpenLocationPanelEvent event, Emitter<LocationState> emit) =>
      emit(state.copyWith(openLocationPanel: true));

  LandmarkEntity? getCurrentPositionAsLandmark() {
    if (state.currentPosition == null) return null;
    return _landmarkUseCase.getLandmarkAtCoordinates(
        coordinates: state.currentPosition!.coordinates, name: 'My Position');
  }

  @override
  Future<void> close() async {
    await _permissionStreamSubscription.cancel();
    await _positionStreamSubscription.cancel();
    await _locationStatusStreamSubscription.cancel();
    return super.close();
  }
}
