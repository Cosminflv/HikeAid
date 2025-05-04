import 'package:domain/entities/camera_state_entity.dart';

abstract class SettingsRepository {
  Future<void> initSettings();

  Future<void> saveCameraState(MapCameraStateEntity cameraState);
  MapCameraStateEntity getSavedCameraState();

  Future<void> savePrefferedMapStylePath(String path);
  String getSavedPrefferedMapStylePath();
}
