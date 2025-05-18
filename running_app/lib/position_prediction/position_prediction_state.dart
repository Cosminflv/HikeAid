import 'package:equatable/equatable.dart';
import 'package:shared/domain/hike_entity.dart';
import 'package:shared/domain/path_entity.dart';

class PositionPredictionState extends Equatable {
  final PathEntity? importedGPXPath;
  final HikeEntity? currentUserHike;

  final List<double> predictedPositions;

  final bool hasConfirmedHike;
  final bool isPositionTransferEnabled;

  const PositionPredictionState({
    this.importedGPXPath,
    this.currentUserHike,
    this.predictedPositions = const [],
    this.hasConfirmedHike = false,
    this.isPositionTransferEnabled = false,
  });

  PositionPredictionState copyWith({
    PathEntity? importedGPXPath,
    HikeEntity? currentUserHike,
    List<double>? predictedPositions,
    bool? hasConfirmedHike,
    bool? isPositionTransferEnabled,
  }) {
    return PositionPredictionState(
      importedGPXPath: importedGPXPath ?? this.importedGPXPath,
      currentUserHike: currentUserHike ?? this.currentUserHike,
      predictedPositions: predictedPositions ?? this.predictedPositions,
      hasConfirmedHike: hasConfirmedHike ?? this.hasConfirmedHike,
      isPositionTransferEnabled: isPositionTransferEnabled ?? this.isPositionTransferEnabled,
    );
  }

  @override
  List<Object?> get props => [
        importedGPXPath,
        currentUserHike,
        predictedPositions,
        hasConfirmedHike,
        isPositionTransferEnabled,
      ];
}
