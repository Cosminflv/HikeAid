import 'package:data/models/coordinates_entity_impl.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:gem_kit/core.dart';

extension CoordinatesEntityExtension on CoordinatesEntity {
  Coordinates toGemCoordinates() => Coordinates(latitude: latitude, longitude: longitude);

  Future<Landmark> toGemLandmark() async {
    final lmk = Landmark();
    lmk.coordinates = toGemCoordinates();
    return lmk;
  }
}

extension GemCoordinatesExtension on Coordinates {
  CoordinatesEntityImpl toEntityImpl() => CoordinatesEntityImpl(latitude: latitude, longitude: longitude);
}
