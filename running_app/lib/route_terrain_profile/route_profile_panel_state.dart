import 'package:equatable/equatable.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:shared/domain/sections/base_section_entity.dart';
import 'package:shared/domain/sections/steep_section_entity.dart';
import 'package:shared/domain/terrain_profile_entity.dart';

class RouteProfilePanelState extends Equatable {
  final bool isOpened;
  final TerrainProfileEntity? terrainProfile;
  final int startDistance;
  final int endDistance;
  final BaseSectionEntity? currentSection;
  final List<PathEntity> pathsToPresent;
  final (int, int, int) presentColor;
  final CoordinatesEntity? markerCoordinates;
  final int selectedDistance;
  final int totalUp;
  final int totalDown;

  const RouteProfilePanelState({
    this.terrainProfile,
    this.pathsToPresent = const [],
    this.presentColor = (0, 0, 0),
    this.markerCoordinates,
    this.startDistance = 0,
    this.endDistance = 0,
    this.isOpened = false,
    this.currentSection,
    this.selectedDistance = 0,
    this.totalUp = 0,
    this.totalDown = 0,
  });

  RouteProfilePanelState copyWith({
    TerrainProfileEntity? terrainProfile,
    int? startDistance,
    int? endDistance,
    CoordinatesEntity? markerCoordinates,
    List<PathEntity>? pathsToPresent,
    (int, int, int)? presentColor,
    bool? isOpened,
    BaseSectionEntity? currentSection,
    int? selectedDistance,
    int? totalUp,
    int? totalDown,
  }) {
    return RouteProfilePanelState(
      terrainProfile: terrainProfile ?? this.terrainProfile,
      pathsToPresent: pathsToPresent ?? this.pathsToPresent,
      presentColor: presentColor ?? this.presentColor,
      markerCoordinates: markerCoordinates ?? this.markerCoordinates,
      startDistance: startDistance ?? this.startDistance,
      endDistance: endDistance ?? this.endDistance,
      isOpened: isOpened ?? this.isOpened,
      currentSection: currentSection ?? this.currentSection,
      selectedDistance: selectedDistance ?? this.selectedDistance,
      totalUp: totalUp ?? this.totalUp,
      totalDown: totalDown ?? this.totalDown,
    );
  }

  RouteProfilePanelState copyWithNullPath() => RouteProfilePanelState(
        terrainProfile: terrainProfile,
        startDistance: startDistance,
        endDistance: endDistance,
        markerCoordinates: markerCoordinates,
        pathsToPresent: pathsToPresent,
        presentColor: presentColor,
        isOpened: isOpened,
        currentSection: currentSection,
        selectedDistance: selectedDistance,
        totalDown: totalDown,
        totalUp: totalUp,
      );

  DSteepness get currentGrade {
    if (terrainProfile == null) return DSteepness.neutral;

    return terrainProfile!.getSteepSectionAtDist(selectedDistance)?.type ?? DSteepness.neutral;
  }

  @override
  List<Object?> get props => [
        isOpened,
        terrainProfile,
        startDistance,
        endDistance,
        pathsToPresent,
        presentColor,
        markerCoordinates,
        currentSection,
        selectedDistance,
        totalUp,
        totalDown,
      ];
}
