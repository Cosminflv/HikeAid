import 'dart:typed_data';
import 'dart:ui';

import 'package:data/models/coordinates_entity_impl.dart';
import 'package:data/models/landmark_entity_impl.dart';
import 'package:data/models/navigation_instruction_entity_impl.dart';
import 'package:data/models/route_entity_impl.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/transport_means.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/settings/bike_preferences_entity.dart';
import 'package:gem_kit/core.dart';
import 'package:gem_kit/navigation.dart';
import 'package:gem_kit/routing.dart';

extension CoordinatesEntityExtension on CoordinatesEntity {
  Coordinates toGemCoordinates() => Coordinates(latitude: latitude, longitude: longitude);

  Future<Landmark> toGemLandmark() async {
    final lmk = Landmark();
    lmk.coordinates = toGemCoordinates();
    return lmk;
  }
}

extension GemLandmarkExtension on Landmark {
  LandmarkEntityImpl toEntityImpl({int width = 48, int height = 48, Uint8List? image, bool isPositionBased = false}) {
    final landmarkImage = image ?? getImage();

    return LandmarkEntityImpl(
      ref: this,
      icon: landmarkImage,
      isPositionBased: isPositionBased,
    );
  }
}

extension GemCoordinatesExtension on Coordinates {
  CoordinatesEntityImpl toEntity() => CoordinatesEntityImpl(latitude: latitude, longitude: longitude);
}

extension LandmarkEntityExtension on LandmarkEntityImpl {
  Landmark toGemLandmark() {
    final landmark = Landmark();
    landmark.coordinates = coordinates.toGemCoordinates();
    landmark.name = name;
    landmark.setImage(imageData: ref!.getImage()!);

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

extension BikePreferencesEntityExtension on RoutePreferencesEntity {
  RoutePreferences toGemRoutePreferences() {
    final prefs = RoutePreferences(
      transportMode: transportMeans == DTransportMeans.car ? RouteTransportMode.car : RouteTransportMode.pedestrian,
    );

    return prefs;
  }
}

extension GemRouteExtension on Route {
  RouteEntityImpl toEntityImpl(
      {required List<LandmarkEntity> waypoints, bool isTourBased = false, bool isFingerDrawn = false}) {
    final timeDistance = getTimeDistance();
    final time = timeDistance.restrictedTimeS + timeDistance.unrestrictedTimeS;
    final distance = timeDistance.restrictedDistanceM + timeDistance.unrestrictedDistanceM;

    return RouteEntityImpl(
      distance: distance,
      duration: time,
      waypoints: waypoints,
      ref: this,
      isTourBased: isTourBased,
    );
  }
}

extension GemNavigationRouteExtension on NavigationInstruction {
  NavigationInstructionEntityImpl toEntityImpl(
      {int width = 128, int height = 128, required int imageUid, Uint8List? image}) {
    final timeDistance = timeDistanceToNextTurn;

    final distance = timeDistance.restrictedDistanceM + timeDistance.unrestrictedDistanceM;

    final nextStreetName = nextNextStreetName;
    final localCurrentStreetName = currentStreetName;

    final remainingTimeDistance = remainingTravelTimeDistance;
    final remainingDistance = remainingTimeDistance.restrictedDistanceM + remainingTimeDistance.unrestrictedDistanceM;
    final remainingDuration = remainingTimeDistance.restrictedTimeS + remainingTimeDistance.unrestrictedTimeS;

    final turnDetails = nextTurnDetails;

    final speedLimit = currentStreetSpeedLimit;

    image ??= turnDetails.getAbstractGeometryImage(
        size: Size(100, 100), renderSettings: AbstractGeometryImageRenderSettings());

    return NavigationInstructionEntityImpl(
        ref: this,
        distance: distance,
        nextStreetName: nextStreetName,
        currentStreetName: localCurrentStreetName,
        remainingDistance: remainingDistance,
        remainingDuration: remainingDuration,
        currentSpeedLimit: speedLimit,
        imageUid: imageUid,
        image: image);
  }
}

extension ViewAreaEntityExtension on ViewAreaEntity {
  RectType<int> toRectType() {
    return RectType(x: xy.x, y: xy.y, width: size.width.toInt(), height: size.height.toInt());
  }
}
