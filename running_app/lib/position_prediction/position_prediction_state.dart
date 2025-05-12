import 'package:equatable/equatable.dart';
import 'package:shared/domain/path_entity.dart';

class PositionPredictionState extends Equatable {
  final PathEntity? importedGPXPath;
  final bool hasConfirmedHike;

  const PositionPredictionState({
    this.importedGPXPath,
    this.hasConfirmedHike = false,
  });

  PositionPredictionState copyWith({
    PathEntity? importedGPXPath,
    bool? hasConfirmedHike,
  }) {
    return PositionPredictionState(
      importedGPXPath: importedGPXPath ?? this.importedGPXPath,
      hasConfirmedHike: hasConfirmedHike ?? this.hasConfirmedHike,
    );
  }

  @override
  List<Object?> get props => [
        importedGPXPath,
        hasConfirmedHike,
      ];
}
