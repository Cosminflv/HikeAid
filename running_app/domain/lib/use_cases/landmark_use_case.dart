import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/repositories/landmark_repository.dart';

class LandmarkUseCase {
  final LandmarkRepository _landmarkRepository;

  LandmarkUseCase(this._landmarkRepository);

  LandmarkEntity getLandmarkAtCoordinates(
          {required CoordinatesEntity coordinates, String? name, bool? isPositionBased}) =>
      _landmarkRepository.getLandmarkAtCoordinates(
          coordinates: coordinates, name: name, isPositionBased: isPositionBased);
}
