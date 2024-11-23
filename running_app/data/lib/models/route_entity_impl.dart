import 'package:data/models/coordinates_entity_impl.dart';
import 'package:data/models/landmark_entity_impl.dart';
import 'package:data/repositories_impl/extensions.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/route_entity.dart';

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:gem_kit/core.dart';

class RouteEntityImpl extends RouteEntity {
  final Route ref;

  RouteEntityImpl({
    required super.distance,
    required super.duration,
    required super.waypoints,
    required super.isTourBased,
    required this.ref,
  });

  @override
  LandmarkEntity? getLandmarkAtDistance(int distance) {
    try {
      final landmark = Landmark();
      final coords = ref.getCoordinateOnRoute(distance);

      landmark.setImageFromIcon(GemIcon.searchResultsPin);
      landmark.coordinates = coords;

      return LandmarkEntityImpl(ref: landmark);
    } catch (e) {
      return null;
    }
  }

  @override
  CoordinatesEntity getCoordinatesAtDistance(int distance) {
    final coords = ref.getCoordinateOnRoute(distance);
    return CoordinatesEntityImpl(latitude: coords.latitude, longitude: coords.longitude);
  }

  @override
  Future<void> updateWaypoints(CoordinatesEntity coordinates) async {
    Landmark gemLmk = Landmark();
    gemLmk.coordinates = coordinates.toGemCoordinates();
    gemLmk.name = 'My Position';
    final currentPositionLandmark = LandmarkEntityImpl(ref: gemLmk, isPositionBased: isPositionBased);
    final toDelete = isPositionBased ? waypoints.length - ref.getWaypoints().length : 1;

    if (toDelete > 0) {
      waypoints.removeRange(0, toDelete);
      waypoints.insert(0, currentPositionLandmark);
    }
  }

  @override
  bool equals(RouteEntity route) => ref.equals((route as RouteEntityImpl).ref);

  @override
  int get id => ref.hashCode;

  @override
  CoordinatesEntity get middleCoordinates => ref.getCoordinateOnRoute(distance ~/ 2).toEntity();

  @override
  int get totalDown => ref.terrainProfile?.totalDown.toInt() ?? 0;

  @override
  int get totalUp => ref.terrainProfile?.totalUp.toInt() ?? 0;

  @override
  int getTimeAtDistance(int distance) {
    final coords = ref.getCoordinateOnRoute(distance);
    final timeDistance = ref.getTimeDistanceCoordinateOnRoute(coords);
    return timeDistance.stamp ?? 0;
  }

  @override
  Uint8List exportToGpx() => ref.exportAs(PathFileFormat.gpx);

  @override
  double distanceToRoute(CoordinatesEntity coordinates) {
    final timeDistance = ref.getTimeDistanceCoordinateOnRoute(coordinates.toGemCoordinates());
    if (timeDistance.coords == null) return -1;
    return _calculateDistance(coordinates, timeDistance.coords!.toEntity());
  }

  double _calculateDistance(CoordinatesEntity coords1, CoordinatesEntity coords2) {
    const R = 6371000;
    final latDistance = (coords2.latitude - coords1.latitude) * (pi / 180);
    final lonDistance = (coords2.longitude - coords1.longitude) * (pi / 180);

    final a = sin(latDistance / 2) * sin(latDistance / 2) +
        cos(coords1.latitude * (pi / 180)) *
            cos(coords2.latitude * (pi / 180)) *
            sin(lonDistance / 2) *
            sin(lonDistance / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = R * c;
    return distance;
  }
}
