import 'package:shared/domain/sections/base_section_entity.dart';

enum DSteepness {
  descendExtreme,
  descendVeryHigh,
  descendHigh,
  descendLow,
  descendVeryLow,
  neutral,
  ascendVeryLow,
  ascendLow,
  ascendHigh,
  ascendVeryHigh,
  ascendExtreme,
}

abstract class SteepSectionEntity extends BaseSectionEntity<DSteepness> {
  int get startDistance;
  int get endDistance;

  @override
  List<Object?> get props => [startDistance, endDistance];
}
