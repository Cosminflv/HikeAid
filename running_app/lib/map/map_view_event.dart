abstract class MapViewEvent {}

class InitMapViewEvent extends MapViewEvent {
  final String? instanceName;
  final bool isInteractive;

  InitMapViewEvent({
    this.instanceName,
    this.isInteractive = true,
  });
}
