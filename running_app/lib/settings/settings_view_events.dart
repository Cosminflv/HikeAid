abstract class SettingsViewEvent {}

class SavePrefferedMapStyleEvent extends SettingsViewEvent {
  final String path;

  SavePrefferedMapStyleEvent(this.path);
}
