import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';

abstract class LandmarkRepository {
  LandmarkEntity getLandmarkAtCoordinates(
      {required CoordinatesEntity coordinates, String? name, bool? isPositionBased});

  Future<LandmarkEntity?> getClosestLandmark(CoordinatesEntity coordinates);
}
