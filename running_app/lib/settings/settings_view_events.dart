import 'package:domain/entities/camera_state_entity.dart';

abstract class SettingsViewEvent {}

class SavePrefferedMapStyleEvent extends SettingsViewEvent {
  final String path;

  SavePrefferedMapStyleEvent(this.path);
}

class SaveSettingsEvent extends SettingsViewEvent {}

class LoadSettingsEvent extends SettingsViewEvent {}

class SettingsCameraStateUpdatedEvent extends SettingsViewEvent {
  final MapCameraStateEntity coordinates;
  SettingsCameraStateUpdatedEvent(this.coordinates);
}
