import 'package:data/utils/map_widget_builder_impl.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:domain/map_controller.dart';
import 'package:gem_kit/map.dart';

class MapRepositoryImpl extends MapRepository {
  final GemMapController _controller;

  MapRepositoryImpl(MapController mapController) : _controller = (mapController as MapControllerImpl).ref;

  @override
  void registerMapGesturesCallbacks({required Function() onMapMove}) {
    _controller.registerMoveCallback((p1, p2) => onMapMove());
  }

  @override
  void setEnableTouchGestures(bool enable) {
    _controller.preferences.enableTouchGestures(TouchGestures.values, enable);
  }
}
