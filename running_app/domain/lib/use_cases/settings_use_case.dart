import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/repositories/settings_repository.dart';

class SettingsUseCase {
  final SettingsRepository _settingsRepository;

  SettingsUseCase(this._settingsRepository);

  Future<void> init() async => await _settingsRepository.initSettings();

  Future<void> saveCameraState(MapCameraStateEntity cameraState) async =>
      await _settingsRepository.saveCameraState(cameraState);

  MapCameraStateEntity getSavedCameraState() => _settingsRepository.getSavedCameraState();

  Future<void> savePrefferedMapStylePath(String path) => _settingsRepository.savePrefferedMapStylePath(path);
  String getSavedPrefferedMapStylePath() => _settingsRepository.getSavedPrefferedMapStylePath();
}
