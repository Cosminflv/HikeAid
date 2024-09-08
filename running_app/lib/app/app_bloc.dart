import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/sdk_settings_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  //final SDKSettingsUseCase _sdkSettingsUseCase;

  AppBloc()
      : //_sdkSettingsUseCase = sl.get<SDKSettingsUseCase>(),
        super(const AppState()) {
    on<UpdateAppStatusEvent>(_handleAppStatusUpdated);
    // on<UpdateMapLabelsLanguageEvent>(_handleUpdateMapLabelsLanguage);
    // on<UpdateDistanceUnitEvent>(_handleUpdateDistanceUnit);
    // on<UpdateMobileDataAllowanceEvent>(_handleUpdateMobileDataAllowance);
    // on<UpdateAppStatusBarBrightnessEvent>(_handleUpdateAppStatusBarBrightness);
  }

  _handleAppStatusUpdated(UpdateAppStatusEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(status: event.status));
  }

  // _handleUpdateMapLabelsLanguage(UpdateMapLabelsLanguageEvent event, Emitter<AppState> emit) =>
  //     _sdkSettingsUseCase.setMapLabelsLanguage(event.type);

  // _handleUpdateDistanceUnit(UpdateDistanceUnitEvent event, Emitter<AppState> emit) {
  //   emit(state.copyWith(distanceUnit: event.unit));
  //   _sdkSettingsUseCase.setDistanceUnitType(event.unit);
  // }

  // _handleUpdateMobileDataAllowance(UpdateMobileDataAllowanceEvent event, Emitter<AppState> emit) =>
  //     _sdkSettingsUseCase.setAllowMobileData(event.allow);

  // _handleUpdateAppStatusBarBrightness(UpdateAppStatusBarBrightnessEvent event, Emitter<AppState> emit) =>
  //     emit(state.copyWith(statusBarBrightness: event.statusAppBrightness));
}
