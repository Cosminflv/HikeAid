import 'dart:typed_data';

import 'package:data/models/landmark_entity_impl.dart';
import 'package:data/models/path_entity_impl.dart';
import 'package:data/repositories_impl/extensions.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/path_entity.dart';
import 'package:domain/entities/tour_entity.dart';
import 'package:gem_kit/core.dart';

class TourEntityImpl extends TourEntity {
  TourEntityImpl({
    required super.coordinates,
    required super.name,
    required super.filePath,
    required super.size,
    required super.distance,
    required super.duration,
    required super.totalUp,
    required super.totalDown,
    required super.type,
    super.preview,
    super.date,
  });

  @override
  double get averageSpeed => distance / duration;

  @override
  String getCorrespondingPreviewPath(String previewsDirectory) {
    if (type == TourTypes.completed) return '$previewsDirectory/${name.replaceFirst('gpx', 'jpg')}';
    final dateRegExp = RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}');
    String newName = name;

    if (!dateRegExp.hasMatch(name)) {
      newName = '${date}_$name';
    }
    return '$previewsDirectory/${newName.replaceFirst('gpx', 'jpg')}';
  }

  @override
  TourEntity copyWith({String? name, Uint8List? preview, int? duration}) => TourEntityImpl(
        preview: preview ?? this.preview,
        coordinates: coordinates,
        name: name ?? this.name,
        filePath: filePath,
        date: date,
        size: size,
        distance: distance,
        duration: duration ?? this.duration,
        totalUp: totalUp,
        totalDown: totalDown,
        type: type,
      );

  @override
  PathEntity get path =>
      PathEntityImpl(ref: Path.fromCoordinates(coordinates.map((e) => e.latLng.toGemCoordinates()).toList()));

  @override
  LandmarkEntity get endLandmark =>
      LandmarkEntityImpl(ref: Landmark()..coordinates = coordinates.last.latLng.toGemCoordinates());

  @override
  LandmarkEntity get startLandmark =>
      LandmarkEntityImpl(ref: Landmark()..coordinates = coordinates.first.latLng.toGemCoordinates());
}
