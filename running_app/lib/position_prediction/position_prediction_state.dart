import 'package:equatable/equatable.dart';
import 'package:shared/domain/hike_entity.dart';
import 'package:shared/domain/path_entity.dart';

class PositionPredictionState extends Equatable {
  final PathEntity? importedGPXPath;
  final HikeEntity? currentUserHike;

  final bool hasConfirmedHike;
  final bool isPositionTransferEnabled;

  const PositionPredictionState({
    this.importedGPXPath,
    this.currentUserHike,
    this.hasConfirmedHike = false,
    this.isPositionTransferEnabled = false,
  });

  PositionPredictionState copyWith({
    PathEntity? importedGPXPath,
    HikeEntity? currentUserHike,
    bool? hasConfirmedHike,
    bool? isPositionTransferEnabled,
  }) {
    return PositionPredictionState(
      importedGPXPath: importedGPXPath ?? this.importedGPXPath,
      currentUserHike: currentUserHike ?? this.currentUserHike,
      hasConfirmedHike: hasConfirmedHike ?? this.hasConfirmedHike,
      isPositionTransferEnabled: isPositionTransferEnabled ?? this.isPositionTransferEnabled,
    );
  }

  @override
  List<Object?> get props => [
        importedGPXPath,
        currentUserHike,
        hasConfirmedHike,
        isPositionTransferEnabled,
      ];
}
