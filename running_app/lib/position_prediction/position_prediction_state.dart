import 'package:equatable/equatable.dart';
import 'package:shared/domain/path_entity.dart';

class PositionPredictionState extends Equatable {
  final PathEntity? importedGPXPath;
  final bool hasConfirmedHike;
  final bool isPositionTransferEnabled;

  const PositionPredictionState({
    this.importedGPXPath,
    this.hasConfirmedHike = false,
    this.isPositionTransferEnabled = false,
  });

  PositionPredictionState copyWith({
    PathEntity? importedGPXPath,
    bool? hasConfirmedHike,
    bool? isPositionTransferEnabled,
  }) {
    return PositionPredictionState(
      importedGPXPath: importedGPXPath ?? this.importedGPXPath,
      hasConfirmedHike: hasConfirmedHike ?? this.hasConfirmedHike,
      isPositionTransferEnabled: isPositionTransferEnabled ?? this.isPositionTransferEnabled,
    );
  }

  @override
  List<Object?> get props => [
        importedGPXPath,
        hasConfirmedHike,
        isPositionTransferEnabled,
      ];
}
