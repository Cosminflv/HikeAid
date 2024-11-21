import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';

import 'package:equatable/equatable.dart';

import 'dart:typed_data';

class LandmarkWithDistanceEntity extends Equatable {
  final LandmarkEntity landmark;
  final int distance;

  LandmarkWithDistanceEntity(this.landmark, CoordinatesEntity? coordinates)
      : distance = coordinates != null ? landmark.coordinates.getDistanceTo(coordinates).toInt() : 0;

  String get name => landmark.name;
  String get address => landmark.address;
  Uint8List? get icon => landmark.icon;
  CoordinatesEntity get coordinates => landmark.coordinates;

  @override
  List<Object?> get props => [landmark, distance];
}
