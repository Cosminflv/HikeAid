import 'package:gem_kit/routing.dart';
import 'package:shared/domain/sections/road_section_entity.dart';

// ignore: must_be_immutable
class RoadSectionEntityImpl extends RoadSectionEntity {
  final RoadType roadType;

  final int routeLength;

  @override
  int sectionLength = 0;

  RoadSectionEntityImpl({required this.roadType, required this.routeLength});

  @override
  DRoadType get type => parseToRoadType(roadType);

  static DRoadType parseToRoadType(RoadType? roadType) {
    switch (roadType) {
      case RoadType.motorways:
        return DRoadType.motorway;
      case RoadType.stateRoad:
        return DRoadType.stateRoad;
      case RoadType.road:
        return DRoadType.road;
      case RoadType.street:
        return DRoadType.street;
      case RoadType.cycleway:
        return DRoadType.cycleway;
      case RoadType.path:
        return DRoadType.path;
      case RoadType.singleTrack:
        return DRoadType.singleTrack;
      default:
        throw Exception("Unknown road type");
    }
  }

  @override
  double get percent => routeLength != 0 ? sectionLength / routeLength : 0;
}
