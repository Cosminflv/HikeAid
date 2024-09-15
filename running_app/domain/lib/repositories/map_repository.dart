import 'dart:typed_data';

import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/coordinates_entity.dart';

abstract class MapRepository {
  // Gestures
  void registerMapGesturesCallbacks({
    required Function() onMapMove,
    required Function(double) onMapAngleUpdated,
  });

  // Center and Distance
  CoordinatesEntity? getCenterCoordinates();
  MapCameraStateEntity? getCameraState();

  // Miscellaneous
  void setPositionTrackerImage(Uint8List imageData, {double scale = 1.0});
  void alignNorthUp();

  void setEnableTouchGestures(bool enable);
}
