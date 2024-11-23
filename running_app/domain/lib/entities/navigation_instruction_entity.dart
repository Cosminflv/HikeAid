import 'package:domain/entities/route_instruction_entity.dart';

abstract class NavigationInstructionEntity extends RouteInstructionEntity {
  final int remainingDistance;
  final int remainingDuration;

  final int imageUid;

  final double currentSpeedLimit;
  final String currentStreetName;
  final String nextStreetName;

  NavigationInstructionEntity({
    required super.distance,
    required this.nextStreetName,
    required this.currentStreetName,
    required this.currentSpeedLimit,
    required this.remainingDistance,
    required this.remainingDuration,
    required this.imageUid,
    super.image,
  });

  int get distanceToNextWaypoint;
}
