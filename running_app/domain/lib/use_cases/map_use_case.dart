import 'dart:typed_data';

import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/repositories/camera_repository.dart';
import 'package:domain/repositories/map_repository.dart';

class MapUseCase {
  final MapRepository _mapRepository;
  final CameraRepository _cameraRepository;

  MapUseCase(this._mapRepository, this._cameraRepository);

  void startFollowPosition({
    int zoom = 70,
    double viewAngle = 0,
    Function()? onComplete,
    required PointEntity<double> pointToCenter,
  }) =>
      _cameraRepository.startFollowPosition(
        zoom: zoom,
        viewAngle: viewAngle,
        onComplete: onComplete,
        pointToCenter: pointToCenter,
      );

  void setEnableTouchGestures(bool enable) => _mapRepository.setEnableTouchGestures(enable);

  void registerMapGestureCallbacks({required Function(double) onMapAngleUpdated, required Function() onMapMove}) =>
      _mapRepository.registerMapGesturesCallbacks(onMapAngleUpdated: onMapAngleUpdated, onMapMove: onMapMove);

  MapCameraStateEntity? getCameraState() => _mapRepository.getCameraState();

  void setFollowPositionPreferences(
          {required DFollowPositionRotationMode mode, double angle = 0, bool objectFollowMap = false}) =>
      _cameraRepository.setFollowPositionPreferences(mode: mode, angle: angle, objectFollowMap: objectFollowMap);

  void setPositionTrackerImage(Uint8List imageData, {double scale = 1.0}) =>
      _mapRepository.setPositionTrackerImage(imageData, scale: scale);

  void alignCompassNorth() => _mapRepository.alignNorthUp();
}
