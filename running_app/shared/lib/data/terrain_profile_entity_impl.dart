import 'package:gem_kit/routing.dart';
import 'package:shared/data/sections/climb_section_entity_impl.dart';
import 'package:shared/data/sections/road_section_entity_impl.dart';
import 'package:shared/data/sections/steep_section_entity_impl.dart';
import 'package:shared/data/sections/surface_section_entity_impl.dart';
import 'package:shared/domain/sections/climb_section_entity.dart';
import 'package:shared/domain/sections/road_section_entity.dart';
import 'package:shared/domain/sections/steep_section_entity.dart';
import 'package:shared/domain/sections/surface_section_entity.dart';
import 'package:shared/domain/terrain_profile_entity.dart';

class TerrainProfileEntityImpl extends TerrainProfileEntity {
  RouteTerrainProfile profile;
  final int routeLength;

  TerrainProfileEntityImpl({required this.profile, required this.routeLength});

  @override
  double getElevation(int distance) {
    return profile.getElevation(distance);
  }

  @override
  List<(double, double)> getElevationSamples(int numberOfSamples) {
    final samples = profile.getElevationSamples(numberOfSamples, 0, routeLength);

    double currentDistance = 0;
    List<(double, double)> result = [];
    for (int i = 0; i < samples.first.length; i++) {
      result.add((currentDistance, samples.first[i]));
      currentDistance += samples.second;
    }

    return result;
  }

  @override
  (int, double) getMaxElevation() {
    return (profile.maxElevationDistance, profile.maxElevation);
  }

  @override
  (int, double) getMinElevation() {
    return (profile.minElevationDistance, profile.minElevation);
  }

  @override
  (int, double) getEndElevation() {
    return (routeLength, profile.getElevation(routeLength));
  }

  @override
  (int, double) getStartElevation() {
    return (0, profile.getElevation(0));
  }

  @override
  List<ClimbSectionEntity> getClimbSections() {
    List<ClimbSectionEntity> result = [];
    List<ClimbSection> sections = profile.climbSections;

    final sectionCount = sections.length;
    for (int i = 0; i < sectionCount; i++) {
      final section = sections[i];
      final enm = section.grade!;
      final startDistance = section.startDistanceM ?? 0;
      final endDistance = section.endDistanceM ?? 0;
      final startElevation = profile.getElevation(startDistance);
      final endElevation = profile.getElevation(endDistance);
      final slope = section.slope ?? 0;

      result.add(ClimbSectionEntityImpl(
          grade: enm,
          routeLength: routeLength,
          averageGrade: slope,
          startDistance: startDistance,
          endDistance: endDistance,
          startElevation: startElevation,
          endElevation: endElevation));
    }
    return result;
  }

  @override
  List<RoadSectionEntity> getRoadTypeSections() {
    List<RoadSectionEntity> result = [];
    List<RoadTypeSection> sections = profile.roadTypeSections;

    Map<RoadType, RoadSectionEntityImpl> map = <RoadType, RoadSectionEntityImpl>{};

    final sectionCount = sections.length;
    for (int i = 0; i < sectionCount; i++) {
      final section = sections[i];
      final enm = section.type;
      final isLast = i == sectionCount - 1;
      final startDistance = sections[i].startDistanceM ?? 0;
      final endDistance = isLast ? routeLength : (sections[i + 1].startDistanceM ?? 0);
      final sectionLength = endDistance - startDistance;

      if (!map.containsKey(enm)) {
        map[enm] = RoadSectionEntityImpl(roadType: enm, routeLength: routeLength);
      }
      map[enm]!.sectionLength += sectionLength;
    }

    result.addAll(map.values);
    return result;
  }

  @override
  List<SurfaceSectionEntity> getSurfaceSections() {
    List<SurfaceSectionEntity> result = [];
    List<SurfaceSection> sections = profile.surfaceSections;

    Map<SurfaceType, SurfaceSectionEntityImpl> map = <SurfaceType, SurfaceSectionEntityImpl>{};

    final sectionCount = sections.length;
    for (int i = 0; i < sectionCount; i++) {
      final section = sections[i];
      final enm = section.type!;
      final isLast = i == sectionCount - 1;
      final startDistance = sections[i].startDistanceM ?? 0;
      final endDistance = isLast ? routeLength : (sections[i + 1].startDistanceM ?? 0);
      final sectionLength = endDistance - startDistance;

      if (!map.containsKey(enm)) {
        map[enm] = SurfaceSectionEntityImpl(surfaceType: enm, routeLength: routeLength);
      }
      map[enm]!.sectionLength += sectionLength;
    }

    result.addAll(map.values);
    return result;
  }

  @override
  int getDistance() {
    return routeLength;
  }

  @override
  List<SteepSectionEntity> getSteepSections() {
    List<SteepSectionEntity> result = [];

    final sections = profile.getSteepSections(SteepSectionEntityImpl.categories);

    final sectionCount = sections.length;
    for (int i = 0; i < sectionCount; i++) {
      final section = sections[i];
      final enm = DSteepness.values[section.categ ?? 0];
      final isLast = i == sectionCount - 1;
      final startDistance = sections[i].startDistanceM ?? 0;
      final endDistance = isLast ? routeLength : (sections[i + 1].startDistanceM ?? 0);

      result.add(SteepSectionEntityImpl(
          steepness: enm, routeLength: routeLength, startDistance: startDistance, endDistance: endDistance));
    }

    return result;
  }

  @override
  SteepSectionEntity? getSteepSectionAtDist(int distance) {
    final sections = profile.getSteepSections(SteepSectionEntityImpl.categories);
    final sectionCount = sections.length;

    for (int i = 0; i < sectionCount; i++) {
      final section = sections[i];
      final enm = DSteepness.values[section.categ ?? 0];
      final isLast = i == sectionCount - 1;
      final startDistance = sections[i].startDistanceM ?? 0;
      final endDistance = isLast ? routeLength : (sections[i + 1].startDistanceM ?? 0);

      if (startDistance <= distance && distance <= endDistance) {
        return SteepSectionEntityImpl(
            steepness: enm, routeLength: routeLength, startDistance: startDistance, endDistance: endDistance);
      }
    }

    return null;
  }
}
