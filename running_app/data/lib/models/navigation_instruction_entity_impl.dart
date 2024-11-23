import 'package:domain/entities/navigation_instruction_entity.dart';
import 'package:gem_kit/navigation.dart';

class NavigationInstructionEntityImpl extends NavigationInstructionEntity {
  NavigationInstruction ref;

  NavigationInstructionEntityImpl(
      {required this.ref,
      required super.distance,
      required super.currentStreetName,
      required super.nextStreetName,
      required super.remainingDistance,
      required super.remainingDuration,
      required super.currentSpeedLimit,
      required super.imageUid,
      super.image});

  @override
  int get distanceToNextWaypoint => ref.remainingTravelTimeDistanceToNextWaypoint.totalDistanceM;
}
