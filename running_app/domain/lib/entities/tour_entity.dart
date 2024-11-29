import 'dart:typed_data';

import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/path_entity.dart';

import 'landmark_entity.dart';
import 'position_entity.dart';

enum TourTypes { planned, completed }

abstract class TourEntity {
  final Uint8List? preview;
  final List<CoordinatesWithTimestamp> coordinates;
  final String name;
  final String filePath;
  final String? date;
  final int size;
  final int distance;
  final int duration;
  final int totalUp;
  final int totalDown;

  final TourTypes type;

  TourEntity({
    this.preview,
    required this.coordinates,
    required this.name,
    required this.filePath,
    this.date,
    required this.size,
    required this.distance,
    required this.duration,
    required this.totalUp,
    required this.totalDown,
    required this.type,
  });

  double get averageSpeed => distance / duration;

  String getCorrespondingPreviewPath(String previewsDirectory);

  TourEntity copyWith({String? name, Uint8List? preview, int? duration});

  LandmarkEntity get startLandmark;
  LandmarkEntity get endLandmark;

  PathEntity get path;
}

class CoordinatesWithTimestamp {
  final CoordinatesEntity latLng;
  final double? speed;
  final int altitude;
  final DateTime timestamp;

  CoordinatesWithTimestamp(
    this.latLng,
    this.speed,
    this.altitude,
  ) : timestamp = DateTime.now();

  CoordinatesWithTimestamp.custom({required this.latLng, this.speed, required this.altitude, required this.timestamp});

  factory CoordinatesWithTimestamp.fromPosition(PositionEntity position) => CoordinatesWithTimestamp(
        position.coordinates,
        position.speed,
        position.altitude.toInt(),
      );
}
