import 'package:shared/data/coordinates_entity_impl.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:shared/domain/tour_file_entity.dart';
import 'package:shared/domain/user_profile_entity.dart';

import 'landmark_entity.dart';
import 'position_entity.dart';

abstract class TourEntity {
  final int id;
  final int authorId;
  final String name;
  final DateTime date;
  final int distance;
  final int duration;
  final int totalUp;
  final int totalDown;
  final List<CoordinatesWithTimestamp> coordinates;
  final String previewImageUrl;

  TourEntity({
    required this.id,
    required this.authorId,
    required this.name,
    required this.date,
    required this.distance,
    required this.duration,
    required this.totalUp,
    required this.totalDown,
    required this.coordinates,
    required this.previewImageUrl,
  });

  Map<String, dynamic> toJson(String authorId);

  double get averageSpeed => distance / duration;

  TourEntity copyWith({String? name, String? fileId, int? authorId, bool? isPublic, List<TourFileEntity>? files});

  LandmarkEntity get startLandmark;
  LandmarkEntity get endLandmark;

  PathEntity get path;

  String get formattedDate;

  String get shareURL;

  bool isOwn(int id);

  UserProfileEntity? get authorProfile;
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
    this.timestamp,
  );

  CoordinatesWithTimestamp.custom({required this.latLng, this.speed, required this.altitude, required this.timestamp});

  factory CoordinatesWithTimestamp.fromPosition(PositionEntity position) =>
      CoordinatesWithTimestamp(position.coordinates, position.speed, position.altitude.toInt(), DateTime.now());

  factory CoordinatesWithTimestamp.fromJson(Map<String, dynamic> json) => CoordinatesWithTimestamp.custom(
        latLng: CoordinatesEntityImpl(latitude: json['latitude'], longitude: json['longitude']),
        speed: json['speed'],
        altitude: json['altitude'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          json['timestamp'],
        ),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
        'speed': speed,
        'altitude': altitude,
        'timestamp': timestamp.millisecondsSinceEpoch,
      };
}
