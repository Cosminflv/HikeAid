import 'package:data/models/path_entity_impl.dart';
import 'package:data/repositories_impl/extensions.dart';
import 'package:data/utils/map_widget_builder_impl.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/path_entity.dart';

import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/repositories/camera_repository.dart';
import 'package:domain/map_controller.dart';

import 'package:gem_kit/core.dart';
import 'package:gem_kit/map.dart';

class CameraRepositoryImpl extends CameraRepository {
  final GemMapController _controller;

  final _animationDuration = 100;

  CameraRepositoryImpl(MapController mapController) : _controller = (mapController as MapControllerImpl).ref;

  // Camera Movement Methods
  @override
  void startFollowPosition({
    double viewAngle = 0,
    int zoom = 70,
    Function()? onComplete,
    required PointEntity<double> pointToCenter,
  }) {
    final animation = GemAnimation(type: AnimationType.linear, duration: _animationDuration);

    _controller.preferences.followPositionPreferences.setCameraFocus(XyType(x: pointToCenter.x, y: pointToCenter.y));

    _controller.startFollowingPosition(animation: animation, viewAngle: viewAngle, zoomLevel: zoom);
  }

  @override
  void setFollowPositionPreferences(
          {required DFollowPositionRotationMode mode, double angle = 0, bool objectFollowMap = false}) =>
      _controller.preferences.followPositionPreferences
          .setMapRotationMode(FollowPositionMapRotationMode.values[mode.index], angle: angle, objectFollowMap: true);

  @override
  void registerFollowPositionStateUpdatedCallback(Function(DFollowPositionStatus) onStatusUpdated) => _controller
      .registerFollowPositionStateCallback((status) => onStatusUpdated(DFollowPositionStatus.values[status.index]));

  @override
  void centerOnCoordinates(
      {required CoordinatesEntity coordinates,
      required PointEntity point,
      double viewAngle = 0,
      int? zoom,
      bool withAnimation = true}) {
    _controller.centerOnCoordinates(coordinates.toGemCoordinates(),
        screenPosition: XyType<int>(x: point.x, y: point.y),
        animation: withAnimation
            ? GemAnimation(type: AnimationType.linear, duration: _animationDuration)
            : GemAnimation(type: AnimationType.none),
        zoomLevel: zoom ?? _controller.zoomLevel,
        viewAngle: viewAngle.toDouble());
  }

  @override
  void centerOnMapRoutes({required ViewAreaEntity area, required bool withAnimation, required addCenterPadding}) {
    var paddedArea = area.toRectType();

    _controller.centerOnRoutes(
        screenRect: paddedArea,
        animation: withAnimation ? GemAnimation(type: AnimationType.linear, duration: 1250) : null);
  }

  @override
  void centerOnPath({required PathEntity path, ViewAreaEntity? area}) {
    path as PathEntityImpl;
    //final vp = _controller.viewport;
    var pathArea = path.ref.area;

    // final viewArea =
    //     area?.toRectType() ?? RectType<int>(x: 50, y: 50, width: vp.width! - 100, height: vp.height! - 100);

    _controller.centerOnArea(pathArea);
  }
}
