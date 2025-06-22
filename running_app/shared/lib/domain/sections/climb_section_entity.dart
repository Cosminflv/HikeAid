import 'package:shared/domain/sections/base_section_entity.dart';

enum DClimbGrade {
  grade1,
  grade2,
  grade3,
  grade4,
  gradeHC,
}

abstract class ClimbSectionEntity extends BaseSectionEntity<DClimbGrade> {
  int get startDistance;
  int get endDistance;
  double get startElevation;
  double get endElevation;

  double get averageGrade;

  @override
  List<Object?> get props => [startDistance, endDistance, startElevation, endElevation, averageGrade];
}
