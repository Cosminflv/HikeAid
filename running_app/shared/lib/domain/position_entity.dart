import 'coordinates_entity.dart';

abstract class PositionEntity {
  final CoordinatesEntity coordinates;
  final double speed;
  final double altitude;

  bool get hasSpeed;

  const PositionEntity({required this.coordinates, required this.speed, required this.altitude});
}
