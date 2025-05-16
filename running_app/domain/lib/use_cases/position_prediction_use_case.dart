import 'package:domain/repositories/position_prediction_repository.dart';
import 'package:shared/domain/path_entity.dart';

class PositionPredictionUseCase {
  final PositionPredictionRepository _repository;

  PositionPredictionUseCase(this._repository);

  Future<PathEntity> importGPXDemo(String assetsFilePath) async => await _repository.importGPXDemo(assetsFilePath);

  Future<bool> confirmHike(PathEntity pathEntity) async => await _repository.confirmHike(pathEntity);
}
