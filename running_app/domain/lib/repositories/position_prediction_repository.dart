import 'package:shared/domain/path_entity.dart';
import 'package:shared/domain/tour_entity.dart';

abstract class PositionPredictionRepository {
  Future<PathEntity> importGPXDemo(String assetsPath);
  Future<bool> confirmHike(PathEntity pathEntity);

  Future<void> registerPositionTransfer(int userId);
  void unregisterPositionTransfer();

  void sendCoordinates(CoordinatesWithTimestamp coordinates); // Add this method
}
