import 'package:gem_kit/core.dart';

import '../domain/coordinates_entity.dart';

class CoordinatesEntityImpl extends CoordinatesEntity {
  CoordinatesEntityImpl({required super.latitude, required super.longitude});

  static CoordinatesEntityImpl fromGemCoordinates(Coordinates coords) =>
      CoordinatesEntityImpl(latitude: coords.latitude, longitude: coords.longitude);

  static CoordinatesEntityImpl fromJson(Map<String, dynamic> json) =>
      CoordinatesEntityImpl(latitude: json['lat'] as double, longitude: json['lon'] as double);

  Coordinates toGemCoordinates() => Coordinates(latitude: latitude, longitude: longitude);

  @override
  double getDistanceTo(CoordinatesEntity coords) {
    return toGemCoordinates().distance(Coordinates(latitude: coords.latitude, longitude: coords.longitude));
  }

  Map<String, double> toJson() => {'lat': latitude, 'lon': longitude};
}
