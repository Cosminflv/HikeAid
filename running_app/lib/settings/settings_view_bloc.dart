import 'package:core/di/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/settings/settings_view_events.dart';
import 'package:running_app/settings/settings_view_state.dart';
import 'package:domain/use_cases/settings_use_case.dart';

class SettingsViewBloc extends Bloc<SettingsViewEvent, SettingsViewState> {
  final SettingsUseCase _settingsUseCase = sl.get<SettingsUseCase>();

  SettingsViewBloc() : super(const SettingsViewState()) {
    // Map
    on<SavePrefferedMapStyleEvent>(_handleSavePrefferedMapStyle);
  }

  // Map

  _handleSavePrefferedMapStyle(SavePrefferedMapStyleEvent event, Emitter<SettingsViewState> emit) =>
      _settingsUseCase.savePrefferedMapStylePath(event.path);
}
