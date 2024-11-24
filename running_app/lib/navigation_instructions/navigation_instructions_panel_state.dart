import 'package:domain/entities/route_instruction_description_entity.dart';
import 'package:equatable/equatable.dart';

class NavigationInstructionPanelState extends Equatable {
  final List<RouteInstructionDescriptionEntity>? instructions;
  final int selectedItemIndex;
  final bool isInstructionListVisible;

  const NavigationInstructionPanelState({
    this.instructions,
    this.selectedItemIndex = -1,
    this.isInstructionListVisible = false,
  });

  RouteInstructionDescriptionEntity? get currentInstructionDescription =>
      instructions == null || selectedItemIndex < 0 || selectedItemIndex > instructions!.length
          ? null
          : instructions![selectedItemIndex];

  NavigationInstructionPanelState copyWith(
      {List<RouteInstructionDescriptionEntity>? instructions, int? selectedItemIndex, bool? isInstructionListVisible}) {
    return NavigationInstructionPanelState(
        instructions: instructions ?? this.instructions,
        selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
        isInstructionListVisible: isInstructionListVisible ?? this.isInstructionListVisible);
  }

  @override
  List<Object?> get props => [instructions, selectedItemIndex, isInstructionListVisible];
}
