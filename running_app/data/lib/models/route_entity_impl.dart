import 'package:data/models/landmark_entity_impl.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/entities/route_instruction_description_entity.dart';

import 'dart:async';
import 'dart:math';

import 'package:gem_kit/core.dart';
import 'package:shared/data/coordinates_entity_impl.dart';
import 'package:shared/data/path_entity_impl.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:shared/domain/sections/road_section_entity.dart';
import 'package:shared/domain/sections/steep_section_entity.dart';
import 'package:shared/domain/sections/surface_section_entity.dart';
import 'package:shared/domain/terrain_profile_entity.dart';
import 'package:shared/data/sections/road_section_entity_impl.dart';
import 'package:shared/data/sections/steep_section_entity_impl.dart';
import 'package:shared/data/sections/surface_section_entity_impl.dart';
import 'package:shared/data/terrain_profile_entity_impl.dart';
import 'package:shared/extensions.dart';

class RouteEntityImpl extends RouteEntity {
  final Route ref;

  RouteEntityImpl({
    required super.distance,
    required super.duration,
    required super.waypoints,
    required super.isTourBased,
    required this.ref,
  });

  @override
  LandmarkEntity? getLandmarkAtDistance(int distance) {
    try {
      final landmark = Landmark();
      final coords = ref.getCoordinateOnRoute(distance);

      landmark.setImageFromIcon(GemIcon.searchResultsPin);
      landmark.coordinates = coords;

      return LandmarkEntityImpl(ref: landmark);
    } catch (e) {
      return null;
    }
  }

  @override
  CoordinatesEntity getCoordinatesAtDistance(int distance) {
    final coords = ref.getCoordinateOnRoute(distance);
    return CoordinatesEntityImpl(latitude: coords.latitude, longitude: coords.longitude);
  }

  @override
  Future<void> updateWaypoints(CoordinatesEntity coordinates) async {
    Landmark gemLmk = Landmark();
    gemLmk.coordinates = coordinates.toGemCoordinates();
    gemLmk.name = 'My Position';
    final currentPositionLandmark = LandmarkEntityImpl(ref: gemLmk, isPositionBased: isPositionBased);
    final toDelete = isPositionBased ? waypoints.length - ref.getWaypoints().length : 1;

    if (toDelete > 0) {
      waypoints.removeRange(0, toDelete);
      waypoints.insert(0, currentPositionLandmark);
    }
  }

  @override
  bool equals(RouteEntity route) => ref.equals((route as RouteEntityImpl).ref);

  @override
  Stream<RouteInstructionDescriptionEntity> getInstructions() {
    final result = StreamController<RouteInstructionDescriptionEntity>();

    // processItems() async {
    //   final segments = ref.segments;
    //   for (final segment in segments) {
    //     final instructionList = segment.instructions;

    //     for (final instruction in instructionList) {
    //       final TimeDistance distance = instruction.traveledTimeDistance;
    //       final TurnDetails turnDetails = instruction.turnDetails;
    //       final String followRoadInstruction = instruction.followRoadInstruction;
    //       final String turnInstruction = instruction.turnInstruction;

    //       final rawDistance = distance.restrictedDistanceM + distance.unrestrictedDistanceM;

    //       final imageData = turnDetails.getAbstractGeometryImage(
    //           size: Size(100, 100), renderSettings: AbstractGeometryImageRenderSettings());

    //       result.add(
    //         RouteInstructionDescriptionEntityImpl(
    //           ref: instruction,
    //           distance: rawDistance,
    //           image: imageData,
    //           followRoadInstruction: followRoadInstruction,
    //           turnInstruction: turnInstruction,
    //         ),
    //       );
    //     }
    //   }
    // }

    // processItems();
    return result.stream;
  }

  @override
  int get id => ref.hashCode;

  @override
  CoordinatesEntity get middleCoordinates => ref.getCoordinateOnRoute(distance ~/ 2).toEntity();

  @override
  int get totalDown => ref.terrainProfile?.totalDown.toInt() ?? 0;

  @override
  int get totalUp => ref.terrainProfile?.totalUp.toInt() ?? 0;

  @override
  int getTimeAtDistance(int distance) {
    final coords = ref.getCoordinateOnRoute(distance);
    final timeDistance = ref.getTimeDistanceCoordinateOnRoute(coords);
    return timeDistance.stamp;
  }

  @override
  String exportToGpx() => ref.exportAs(PathFileFormat.gpx);

  @override
  double distanceToRoute(CoordinatesEntity coordinates) {
    final timeDistance = ref.getTimeDistanceCoordinateOnRoute(coordinates.toGemCoordinates());
    return _calculateDistance(coordinates, timeDistance.coords.toEntity());
  }

  double _calculateDistance(CoordinatesEntity coords1, CoordinatesEntity coords2) {
    const R = 6371000;
    final latDistance = (coords2.latitude - coords1.latitude) * (pi / 180);
    final lonDistance = (coords2.longitude - coords1.longitude) * (pi / 180);

    final a = sin(latDistance / 2) * sin(latDistance / 2) +
        cos(coords1.latitude * (pi / 180)) *
            cos(coords2.latitude * (pi / 180)) *
            sin(lonDistance / 2) *
            sin(lonDistance / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = R * c;
    return distance;
  }

  @override
  PathEntity getPathByDistances(int start, int end) => PathEntityImpl(ref: ref.getPath(start, end)!);

  @override
  PathEntityList getPathsByRoadType(DRoadType roadType) {
    PathEntityList result = [];
    final profile = ref.terrainProfile;
    final sections = profile!.roadTypeSections;

    final sectionCount = sections.length;
    for (int i = 0; i < sectionCount; i++) {
      final section = sections[i];
      final enm = section.type;

      if (RoadSectionEntityImpl.parseToRoadType(enm) != roadType) continue;

      final isLast = i == sectionCount - 1;
      final startDistance = sections[i].startDistanceM ?? 0;
      final endDistance = isLast ? distance : (sections[i + 1].startDistanceM ?? 0);

      final refPath = ref.getPath(startDistance, endDistance);
      if (refPath == null) continue;

      result.add(PathEntityImpl(ref: refPath));
    }
    return result;
  }

  @override
  PathEntityList getPathsBySteepness(DSteepness steepness) {
    final profile = ref.terrainProfile;
    final sections = profile!.getSteepSections(SteepSectionEntityImpl.categories);

    final sectionCount = sections.length;

    PathEntityList result = [];

    for (int i = 0; i < sectionCount; i++) {
      final section = sections[i];
      final enm = DSteepness.values[section.categ ?? 0];

      if (enm != steepness) continue;

      final isLast = i == sectionCount - 1;
      final startDistance = sections[i].startDistanceM ?? 0;
      final endDistance = isLast ? distance : (sections[i + 1].startDistanceM ?? 0);

      final refPath = ref.getPath(startDistance, endDistance)!;
      result.add(PathEntityImpl(ref: refPath));
    }

    return result;
  }

  @override
  PathEntityList getPathsSurfaceType(DSurfaceType surfaceType) {
    final profile = ref.terrainProfile;
    final sections = profile!.surfaceSections;

    final sectionCount = sections.length;

    PathEntityList result = [];

    for (int i = 0; i < sectionCount; i++) {
      final section = sections[i];
      final enm = section.type;

      if (SurfaceSectionEntityImpl.parseToSurfaceType(enm) != surfaceType) {
        continue;
      }

      final isLast = i == sectionCount - 1;
      final startDistance = sections[i].startDistanceM ?? 0;
      final endDistance = isLast ? distance : (sections[i + 1].startDistanceM ?? 0);

      final refPath = ref.getPath(startDistance, endDistance)!;
      result.add(PathEntityImpl(ref: refPath));
    }

    return result;
  }

  @override
  TerrainProfileEntity? get terrainProfile {
    RouteTerrainProfile? profile = ref.terrainProfile;
    if (profile == null) return null;
    return TerrainProfileEntityImpl(profile: profile, routeLength: distance);
  }
}
