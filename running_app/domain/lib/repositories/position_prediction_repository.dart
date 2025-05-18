import 'package:shared/domain/path_entity.dart';
import 'package:shared/domain/tour_entity.dart';
import 'package:shared/domain/hike_entity.dart';

abstract class PositionPredictionRepository {
  Future<PathEntity> importGPXDemo(String assetsPath);
  Future<bool> confirmHike(PathEntity pathEntity);
  Future<HikeEntity?> getCurrentHike(int userId);

  Future<List<double>> predictPositions(int userId);

  Future<void> registerPositionTransfer(int userId);
  void unregisterPositionTransfer();

  void sendCoordinates(CoordinatesWithTimestamp coordinates); // Add this method
}
