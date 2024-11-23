import 'dart:typed_data';

abstract class RouteInstructionEntity {
  int distance;
  Uint8List? image;

  RouteInstructionEntity({required this.distance, this.image});
}
