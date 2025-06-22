import 'package:shared/domain/sections/climb_section_entity.dart';
import 'package:shared/domain/sections/road_section_entity.dart';
import 'package:shared/domain/sections/steep_section_entity.dart';
import 'package:shared/domain/sections/surface_section_entity.dart';

abstract class TerrainProfileEntity {
  double getElevation(int distance);

  (int, double) getMaxElevation();
  (int, double) getMinElevation();
  (int, double) getStartElevation();
  (int, double) getEndElevation();

  List<(double, double)> getElevationSamples(int numberOfSamples);

  List<RoadSectionEntity> getRoadTypeSections();
  List<SurfaceSectionEntity> getSurfaceSections();
  List<ClimbSectionEntity> getClimbSections();

  SteepSectionEntity? getSteepSectionAtDist(int distance);

  List<SteepSectionEntity> getSteepSections();

  int getDistance();
}
