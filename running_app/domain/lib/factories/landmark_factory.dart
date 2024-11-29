import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';

abstract class LandmarkFactory {
  LandmarkEntity produce(CoordinatesEntity coordinates);
}
