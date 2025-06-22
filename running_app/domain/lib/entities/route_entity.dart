import 'package:domain/entities/route_instruction_description_entity.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:shared/domain/sections/road_section_entity.dart';
import 'package:shared/domain/sections/steep_section_entity.dart';
import 'package:shared/domain/sections/surface_section_entity.dart';
import 'package:shared/domain/terrain_profile_entity.dart';

abstract class RouteEntity {
  final List<LandmarkEntity> waypoints;
  final int distance;
  final int duration;

  int get id;

  bool get isPositionBased => waypoints.first.isPositionBased;

  int get totalUp;
  int get totalDown;

  final bool isTourBased;

  RouteEntity({
    required this.distance,
    required this.duration,
    required this.waypoints,
    this.isTourBased = false,
  });

  List<LandmarkEntity> getWaypoints() => waypoints;

  Future<void> updateWaypoints(CoordinatesEntity coordinates);

  LandmarkEntity? getLandmarkAtDistance(int distance);
  CoordinatesEntity getCoordinatesAtDistance(int distance);
  int getTimeAtDistance(int distance);

  Stream<RouteInstructionDescriptionEntity> getInstructions();

  bool equals(RouteEntity route);

  CoordinatesEntity get middleCoordinates;

  String exportToGpx();

  double distanceToRoute(CoordinatesEntity coordinates);

  TerrainProfileEntity? get terrainProfile;

  PathEntity getPathByDistances(int start, int end);
  PathEntityList getPathsByRoadType(DRoadType roadType);
  PathEntityList getPathsBySteepness(DSteepness steepness);
  PathEntityList getPathsSurfaceType(DSurfaceType surfaceType);
}
