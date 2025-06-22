import 'package:gem_kit/routing.dart';
import 'package:shared/domain/sections/surface_section_entity.dart';

// ignore: must_be_immutable
class SurfaceSectionEntityImpl extends SurfaceSectionEntity {
  final SurfaceType surfaceType;
  final int routeLength;

  @override
  int sectionLength = 0;

  SurfaceSectionEntityImpl({required this.surfaceType, required this.routeLength});

  @override
  DSurfaceType get type => parseToSurfaceType(surfaceType);

  static DSurfaceType parseToSurfaceType(SurfaceType? roadType) {
    switch (roadType) {
      case SurfaceType.asphalt:
        return DSurfaceType.asphalt;
      case SurfaceType.paved:
        return DSurfaceType.paved;
      case SurfaceType.unpaved:
        return DSurfaceType.unpaved;
      case SurfaceType.unknown:
        return DSurfaceType.unknown;
      default:
        throw Exception("Unknown road type");
    }
  }

  @override
  double get percent => routeLength != 0 ? sectionLength / routeLength : 0;
}
