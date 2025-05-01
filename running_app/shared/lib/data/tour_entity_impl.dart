import 'package:intl/intl.dart';
import 'package:gem_kit/core.dart';
import 'package:shared/data/landmark_entity_impl.dart';
import 'package:shared/data/path_entity_impl.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:shared/domain/tour_entity.dart';
import 'package:shared/domain/tour_file_entity.dart';
import 'package:shared/domain/user_profile_entity.dart';
import 'package:shared/extensions.dart';

class TourEntityImpl extends TourEntity {
  TourEntityImpl({
    super.id = -1,
    super.fileId = '',
    super.authorId = 0,
    super.files = const [],
    required super.name,
    required super.date,
    required super.distance,
    required super.duration,
    required super.totalUp,
    required super.totalDown,
    required super.coordinates,
    required super.previewImageUrl,
    required super.type,
    this.author,
  });

  final UserProfileEntity? author;

  @override
  double get averageSpeed => distance / duration;

  @override
  String getCorrespondingPreviewPath(String previewsDirectory) {
    if (type == TourType.completed) return '$previewsDirectory/${name.replaceFirst('gpx', 'jpg')}';
    final dateRegExp = RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}');
    String newName = name;

    if (!dateRegExp.hasMatch(name)) {
      newName = '${date}_$name';
    }
    return '$previewsDirectory/${newName.replaceFirst('gpx', 'jpg')}';
  }

  @override
  TourEntity copyWith({
    String? name,
    String? fileId,
    int? authorId,
    bool? isPublic,
    String? previewImageUrl,
    List<TourFileEntity>? files,
  }) =>
      TourEntityImpl(
        id: id,
        fileId: fileId ?? this.fileId,
        authorId: authorId ?? this.authorId,
        name: name ?? this.name,
        date: date,
        distance: distance,
        duration: duration,
        totalUp: totalUp,
        totalDown: totalDown,
        coordinates: coordinates,
        previewImageUrl: previewImageUrl ?? this.previewImageUrl,
        type: type,
        author: author,
        files: files ?? this.files,
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

  @override
  String get formattedDate => DateFormat('MMMM d, y, hh:mm a').format(date);

  @override
  Map<String, dynamic> toJson(String authorId) => {
        'author_id': authorId,
        'name': name,
        'distance': distance,
        'duration': duration,
        'totalUp': totalUp,
        'totalDown': totalDown,
        'coordinates': coordinates.map((e) => e.toJson()).toList(),
        'type': type.toString(),
      };

  factory TourEntityImpl.fromJson(Map<String, dynamic> json) => TourEntityImpl(
        id: json['id'],
        fileId: json['file_id'],
        authorId: json['author_id'],
        name: json['name'] as String,
        date: DateTime.parse(json['created_at'] as String),
        distance: json['distance'],
        duration: json['duration'],
        totalUp: json['totalUp'],
        totalDown: json['totalDown'],
        coordinates: (json['coordinates'] as List<dynamic>).map((e) => CoordinatesWithTimestamp.fromJson(e)).toList(),
        previewImageUrl: (json['preview_image_url'] as String),
        type: TourType.fromString(json['type']),
        author: null, //TODO: CHANGE THIS TO AUTHOR PROFILE ENTITY
      );

  @override
  String get shareURL => 'https://generalmagic.com/share_tour?tour=$id';

  @override
  bool isOwn(int id) => id == authorId;

  @override
  UserProfileEntity? get authorProfile => author;
}
