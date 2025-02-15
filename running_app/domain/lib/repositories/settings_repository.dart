abstract class SettingsRepository {
  Future<void> initSettings();

  Future<void> savePrefferedMapStylePath(String path);
  String getSavedPrefferedMapStylePath();
}
