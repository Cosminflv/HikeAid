abstract class MapRepository {
  // Gestures
  void registerMapGesturesCallbacks({
    required Function() onMapMove,
  });

  void setEnableTouchGestures(bool enable);
}
