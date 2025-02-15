import 'package:domain/entities/local_map_style_entity.dart';

abstract class MapStylesPanelEvent {}

class ToggleMapStylesVisibilityEvent extends MapStylesPanelEvent {}

class InitLocalMapStylesEvent extends MapStylesPanelEvent {
  final String? mapStylePath;

  InitLocalMapStylesEvent(this.mapStylePath);
}

class SelectMapStyleEvent extends MapStylesPanelEvent {
  final LocalMapStyleEntity style;
  SelectMapStyleEvent(this.style);
}
