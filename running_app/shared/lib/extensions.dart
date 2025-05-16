import 'package:gem_kit/core.dart';
import 'package:shared/data/landmark_entity_impl.dart';

import 'data/coordinates_entity_impl.dart';
import 'domain/coordinates_entity.dart';

extension CoordinatesEntityExtension on CoordinatesEntity {
  Coordinates toGemCoordinates() => Coordinates(latitude: latitude, longitude: longitude);

  Landmark toGemLandmark() {
    final lmk = Landmark();
    lmk.coordinates = toGemCoordinates();
    return lmk;
  }
}

extension CoordinatesExtension on Coordinates {
  CoordinatesEntityImpl toEntity() => CoordinatesEntityImpl(latitude: latitude, longitude: longitude);
}

extension LandmarkEntityExtension on LandmarkEntityImpl {
  Landmark toGemLandmark() {
    final landmark = Landmark();
    landmark.coordinates = coordinates.toGemCoordinates();
    landmark.name = name;
    if (ref!.getImage() != null) landmark.setImage(imageData: ref!.getImage()!);

    return landmark;
  }
}

extension AddressInfoExtension on AddressInfo {
  String toAddressString() {
    final country = getField(AddressField.country);
    final city = getField(AddressField.city);
    final street = getField(AddressField.streetName);
    return '${street ?? ""} ${city ?? ""} ${country ?? ""}';
  }
}

extension GemCoordinatesExtension on Coordinates {
  CoordinatesEntityImpl toEntityImpl() => CoordinatesEntityImpl(latitude: latitude, longitude: longitude);
}
