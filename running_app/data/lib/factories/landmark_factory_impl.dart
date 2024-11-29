import 'package:data/models/landmark_entity_impl.dart';
import 'package:data/repositories_impl/extensions.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/factories/landmark_factory.dart';
import 'package:gem_kit/core.dart';

class LandmarkFactoryImpl extends LandmarkFactory {
  @override
  LandmarkEntity produce(CoordinatesEntity coordinates) =>
      LandmarkEntityImpl(ref: Landmark()..coordinates = coordinates.toGemCoordinates());
}
