import 'package:domain/entities/view_area_entity.dart';

enum DFollowPositionStatus { entered, exited }

enum DFollowPositionRotationMode { positionHeading, compass, fixed }

class CameraMoveOffsetEntity {
  final PointEntity xOffset;
  final PointEntity yOffset;

  CameraMoveOffsetEntity({required this.xOffset, required this.yOffset});
}

abstract class CameraRepository {
  // Callbacks
  void registerFollowPositionStateUpdatedCallback(Function(DFollowPositionStatus) onStatusUpdated);

  // Camera Movement Methods
  void startFollowPosition({
    double viewAngle = 0,
    int zoom = 70,
    Function()? onComplete,
    required PointEntity<double> pointToCenter,
  });

  void setFollowPositionPreferences(
      {required DFollowPositionRotationMode mode, double angle = 0, bool objectFollowMap = false});
}
