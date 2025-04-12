import 'package:equatable/equatable.dart';
import 'package:shared/domain/tour_entity.dart';

abstract class TourFileEntity extends Equatable {
  final String? remoteName;
  final String? localPath;
  final int distance;

  TourFileEntity({
    this.remoteName,
    this.localPath,
    required this.distance,
  });

  TourFileEntity copyWithName(String name);

  String? getImageURL(TourEntity tour);

  @override
  List<Object?> get props => [
        remoteName,
        localPath,
        distance,
      ];
}
