import 'dart:typed_data';

import 'package:data/models/camera_state_entity_impl.dart';
import 'package:data/utils/map_widget_builder_impl.dart';
import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:domain/map_controller.dart';
import 'package:data/repositories_impl/extensions.dart';

import 'package:gem_kit/core.dart';
import 'package:gem_kit/map.dart';

class MapRepositoryImpl extends MapRepository {
  final GemMapController _controller;

  MapRepositoryImpl(MapController mapController) : _controller = (mapController as MapControllerImpl).ref;

  @override
  void registerMapGesturesCallbacks({
    required Function() onMapMove,
    required Function(double) onMapAngleUpdated,
  }) {
    _controller.registerOnMapAngleUpdate(onMapAngleUpdated);
    _controller.registerMoveCallback((p1, p2) => onMapMove());
  }

  // Center and Distance
  @override
  CoordinatesEntity? getCenterCoordinates() {
    final size = _controller.viewport;

    return _controller.transformScreenToWgs(XyType(x: size.width! ~/ 2, y: size.height! ~/ 2))?.toEntityImpl();
  }

  @override
  MapCameraStateEntity? getCameraState() {
    final coordinates = getCenterCoordinates();

    if (coordinates == null) return null;

    return MapCameraStateEntityImpl(coordinates: coordinates, zoom: _controller.zoomLevel);
  }

  @override
  void setPositionTrackerImage(Uint8List imageData, {double scale = 1.0}) {
    try {
      MapSceneObject.customizeDefPositionTracker(imageData, SceneObjectFileFormat.tex);
      final positionTracker = MapSceneObject.getDefPositionTracker();

      positionTracker.scale = scale;
    } catch (e) {}
  }

  @override
  void alignNorthUp() => _controller.alignNorthUp();

  @override
  void setEnableTouchGestures(bool enable) {
    _controller.preferences.enableTouchGestures(TouchGestures.values, enable);
  }
}
