import 'dart:async';

import 'package:core/di/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/settings/settings_view_events.dart';
import 'package:running_app/settings/settings_view_state.dart';
import 'package:domain/use_cases/settings_use_case.dart';

class SettingsViewBloc extends Bloc<SettingsViewEvent, SettingsViewState> {
  final SettingsUseCase _settingsUseCase = sl.get<SettingsUseCase>();
  final _initializeCompleter = Completer();

  SettingsViewBloc() : super(const SettingsViewState()) {
    // Map
    on<SavePrefferedMapStyleEvent>(_handleSavePrefferedMapStyle);
    on<SaveSettingsEvent>(_handleSaveSettings);
    on<LoadSettingsEvent>(_handleLoadSettings);

    on<SettingsCameraStateUpdatedEvent>(_handleCenterCoordinatesUpdated);
  }

  _handleSaveSettings(SaveSettingsEvent event, Emitter<SettingsViewState> emit) async {
    await _ensureSettingsInitialization();
    await _settingsUseCase.saveCameraState(state.savedCameraState);
  }

  _handleLoadSettings(LoadSettingsEvent event, Emitter<SettingsViewState> emit) async {
    await _settingsUseCase.init();
    _initializeCompleter.complete();

    final coords = _settingsUseCase.getSavedCameraState();

    emit(state.copyWith(
      savedCameraState: coords,
      isInitialized: true,
    ));
  }

  // Screen
  _handleCenterCoordinatesUpdated(SettingsCameraStateUpdatedEvent event, Emitter<SettingsViewState> emit) async {
    await _ensureSettingsInitialization();
    await _settingsUseCase.saveCameraState(event.coordinates);
    if (isClosed) return;
    emit(state.copyWith(savedCameraState: event.coordinates));
  }

  // Map

  _handleSavePrefferedMapStyle(SavePrefferedMapStyleEvent event, Emitter<SettingsViewState> emit) =>
      _settingsUseCase.savePrefferedMapStylePath(event.path);

  Future<void> _ensureSettingsInitialization() async {
    if (_initializeCompleter.isCompleted) return;

    await _settingsUseCase.init();
    _initializeCompleter.complete();
  }
}
