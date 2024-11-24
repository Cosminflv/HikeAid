import 'package:domain/entities/route_instruction_entity.dart';

abstract class RouteInstructionDescriptionEntity extends RouteInstructionEntity {
  String followRoadInstruction;
  String turnInstruction;

  RouteInstructionDescriptionEntity({
    required this.followRoadInstruction,
    required this.turnInstruction,
    required super.distance,
    required super.image,
  });
}
