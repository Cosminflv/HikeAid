

import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';

abstract class LandmarkFactory {
  LandmarkEntity produce(CoordinatesEntity coordinates);
}
