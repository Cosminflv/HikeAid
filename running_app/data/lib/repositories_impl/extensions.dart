import 'package:data/models/coordinates_entity_impl.dart';
import 'package:data/models/position_entity_impl.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:gem_kit/core.dart';
import 'package:gem_kit/position.dart';

extension CoordinatesEntityExtension on CoordinatesEntity {
  Coordinates toGemCoordinates() => Coordinates(latitude: latitude, longitude: longitude);

  Future<Landmark> toGemLandmark() async {
    final lmk = Landmark();
    lmk.coordinates = toGemCoordinates();
    return lmk;
  }
}

extension GemCoordinatesExtension on Coordinates {
  CoordinatesEntityImpl toEntityImpl() => CoordinatesEntityImpl(latitude: latitude!, longitude: longitude!);
}

extension GemPositionExtension on GemPosition {
  PositionEntityImpl? toEntityImpl() {
    if (!hasCoordinates) return null;
    return PositionEntityImpl(ref: this, coordinates: coordinates.toEntityImpl(), speed: speed, altitude: altitude);
  }
}

extension AddressInfoExtension on AddressInfo {
  String toAddressString() {
    final country = getField(AddressField.country);
    final city = getField(AddressField.city);
    final street = getField(AddressField.streetName);
    return '$street $city $country';
  }
}
