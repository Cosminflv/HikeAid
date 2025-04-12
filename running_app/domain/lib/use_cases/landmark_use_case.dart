import 'package:domain/repositories/landmark_repository.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';

class LandmarkUseCase {
  final LandmarkRepository _landmarkRepository;

  LandmarkUseCase(this._landmarkRepository);

  LandmarkEntity getLandmarkAtCoordinates(
          {required CoordinatesEntity coordinates, String? name, bool? isPositionBased}) =>
      _landmarkRepository.getLandmarkAtCoordinates(
          coordinates: coordinates, name: name, isPositionBased: isPositionBased);
}
