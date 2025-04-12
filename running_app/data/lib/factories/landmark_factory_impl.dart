import 'package:data/models/landmark_entity_impl.dart';
import 'package:domain/factories/landmark_factory.dart';
import 'package:gem_kit/core.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/extensions.dart';

class LandmarkFactoryImpl extends LandmarkFactory {
  @override
  LandmarkEntity produce(CoordinatesEntity coordinates) =>
      LandmarkEntityImpl(ref: Landmark()..coordinates = coordinates.toGemCoordinates());
}
