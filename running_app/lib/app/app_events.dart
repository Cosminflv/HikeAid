import 'package:domain/settings/general_settings_entity.dart';

import 'package:running_app/app/app_state.dart';

abstract class AppEvent {}

class UpdateAppStatusEvent extends AppEvent {
  final AppStatus status;

  UpdateAppStatusEvent(this.status);
}

class UpdateMapLabelsLanguageEvent extends AppEvent {
  final DMapLabelsLanguage type;
  UpdateMapLabelsLanguageEvent(this.type);
}

class UpdateAppStatusBarBrightnessEvent extends AppEvent {
  final AppBrightness statusAppBrightness;

  UpdateAppStatusBarBrightnessEvent(this.statusAppBrightness);
}

class UpdateDistanceUnitEvent extends AppEvent {
  final DDistanceUnit unit;
  UpdateDistanceUnitEvent(this.unit);
}

class UpdateMobileDataAllowanceEvent extends AppEvent {
  final bool allow;
  UpdateMobileDataAllowanceEvent({required this.allow});
}
