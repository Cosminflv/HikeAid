import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';

abstract class LandmarkRepository {
  LandmarkEntity getLandmarkAtCoordinates(
      {required CoordinatesEntity coordinates, String? name, bool? isPositionBased});

  Future<LandmarkEntity?> getClosestLandmark(CoordinatesEntity coordinates);
}
