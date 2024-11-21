import 'package:data/models/coordinates_entity_impl.dart';
import 'package:data/models/landmark_entity_impl.dart';
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

extension LandmarkEntityExtension on LandmarkEntityImpl {
  Landmark toGemLandmark() {
    final landmark = Landmark();
    landmark.coordinates = coordinates.toGemCoordinates();
    landmark.name = name;
    landmark.setImage(imageData: ref!.getImage());

    return landmark;
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

extension LandmarkStoreExtenstion on LandmarkStore {
  void clear() {
    final landmarks = getLandmarks();
    for (final lmk in landmarks) {
      removeLandmark(lmk);
    }
  }
}
