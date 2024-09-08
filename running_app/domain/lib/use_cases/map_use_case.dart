import 'package:domain/repositories/map_repository.dart';

class MapUseCase {
  final MapRepository _mapRepository;

  MapUseCase(this._mapRepository);

  void setEnableTouchGestures(bool enable) => _mapRepository.setEnableTouchGestures(enable);

  void registerMapgestureCallbacks({required Function() onMapMove}) =>
      _mapRepository.registerMapGesturesCallbacks(onMapMove: onMapMove);
}
