import 'package:shared/domain/sections/base_section_entity.dart';

enum DRoadType {
  motorway,
  stateRoad,
  road,
  street,
  cycleway,
  path,
  singleTrack,
}

abstract class RoadSectionEntity extends BaseSectionEntity<DRoadType> {}
