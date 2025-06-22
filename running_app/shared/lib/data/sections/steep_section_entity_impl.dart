// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:shared/domain/sections/steep_section_entity.dart';

class SteepSectionEntityImpl extends SteepSectionEntity {
  final DSteepness _climbSection;

  @override
  final int startDistance;
  @override
  final int endDistance;

  final int routeLength;

  @override
  final int sectionLength = 0;

  @override
  DSteepness get type => _climbSection;

  SteepSectionEntityImpl(
      {required DSteepness steepness,
      required this.routeLength,
      required this.startDistance,
      required this.endDistance})
      : _climbSection = steepness;

  @override
  double get percent => routeLength != 0 ? sectionLength / routeLength : 0;

  static const categories = [-16.0, -10.0, -7.0, -4.0, -1.0, 1.0, 4.0, 7.0, 10.0, 16.0];
}
