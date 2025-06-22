import 'package:shared/domain/sections/base_section_entity.dart';

enum DSurfaceType {
  paved,
  unpaved,
  asphalt,
  unknown,
}

abstract class SurfaceSectionEntity extends BaseSectionEntity<DSurfaceType> {}
