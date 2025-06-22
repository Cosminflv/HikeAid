import 'package:equatable/equatable.dart';

abstract class BaseSectionEntity<E> extends Equatable {
  int get sectionLength;
  double get percent;
  E get type;

  @override
  List<Object?> get props => [sectionLength, percent, type];
}
