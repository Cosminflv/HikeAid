import 'package:domain/repositories/position_prediction_repository.dart';
import 'package:shared/domain/hike_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:shared/domain/tour_entity.dart';

class PositionPredictionUseCase {
  final PositionPredictionRepository _repository;

  PositionPredictionUseCase(this._repository);

  Future<PathEntity> importGPXDemo(String assetsFilePath) async => await _repository.importGPXDemo(assetsFilePath);

  Future<bool> confirmHike(PathEntity pathEntity) async => await _repository.confirmHike(pathEntity);
  Future<HikeEntity?> getCurrentHike(int userId) async => await _repository.getCurrentHike(userId);

  Future<List<double>> predictPositions(int userId) async => await _repository.predictPositions(userId);

  Future<void> registerPositionTransfer(int userId) async => await _repository.registerPositionTransfer(userId);
  void unregisterPositionTransfer() => _repository.unregisterPositionTransfer();

  void sendCoordinates(CoordinatesWithTimestamp coordinates) => _repository.sendCoordinates(coordinates);
}
