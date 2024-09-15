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

  void registerMapgestureCallbacks({required Function() onMapMove}) =>
      _mapRepository.registerMapGesturesCallbacks(onMapMove: onMapMove);

  MapCameraStateEntity? getCameraState() => _mapRepository.getCameraState();
}
