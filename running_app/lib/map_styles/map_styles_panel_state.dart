import 'package:domain/entities/local_map_style_entity.dart';
import 'package:equatable/equatable.dart';

class MapStylesPanelState extends Equatable {
  final bool isVisible;
  final LocalMapStyleEntity? selectedMapStyle;
  final List<LocalMapStyleEntity> styles;

  const MapStylesPanelState({
    this.isVisible = false,
    this.styles = const [],
    this.selectedMapStyle,
  });

  LocalMapStyleEntity? getStyleByPath(String path) => styles.isEmpty
      ? null
      : styles.firstWhere(
          (e) => e.path == path,
          orElse: () => styles.first,
        );

  MapStylesPanelState copyWith({
    bool? isVisible,
    LocalMapStyleEntity? selectedMapStyle,
    List<LocalMapStyleEntity>? styles,
  }) =>
      MapStylesPanelState(
        isVisible: isVisible ?? this.isVisible,
        selectedMapStyle: selectedMapStyle ?? this.selectedMapStyle,
        styles: styles ?? this.styles,
      );

  @override
  List<Object?> get props => [
        isVisible,
        selectedMapStyle,
        styles,
      ];
}
