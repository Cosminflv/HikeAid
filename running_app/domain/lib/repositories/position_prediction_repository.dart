import 'package:shared/domain/path_entity.dart';

abstract class PositionPredictionRepository {
  Future<PathEntity> importGPXDemo(String assetsPath);
  Future<bool> confirmHike(PathEntity pathEntity);
}
