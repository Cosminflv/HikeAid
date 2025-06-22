// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:gem_kit/routing.dart';
import 'package:shared/domain/sections/climb_section_entity.dart';

class ClimbSectionEntityImpl extends ClimbSectionEntity {
  final Grade grade;

  final int routeLength;

  @override
  final double averageGrade;

  @override
  int get sectionLength => endDistance - startDistance;

  @override
  final int startDistance;

  @override
  final int endDistance;

  @override
  final double startElevation;

  @override
  final double endElevation;

  ClimbSectionEntityImpl({
    required this.grade,
    required this.routeLength,
    required this.averageGrade,
    required this.startDistance,
    required this.endDistance,
    required this.startElevation,
    required this.endElevation,
  });

  @override
  DClimbGrade get type => parseToClimbGrade(grade);

  static DClimbGrade parseToClimbGrade(Grade? roadType) {
    switch (roadType) {
      case Grade.grade1:
        return DClimbGrade.grade1;
      case Grade.grade2:
        return DClimbGrade.grade2;
      case Grade.grade3:
        return DClimbGrade.grade3;
      case Grade.grade4:
        return DClimbGrade.grade4;
      case Grade.gradeHC:
        return DClimbGrade.gradeHC;
      default:
        throw Exception("Unknown road type");
    }
  }

  @override
  double get percent => routeLength != 0 ? sectionLength / routeLength : 0;
}
