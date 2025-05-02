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
    super.authorId = 0,
    required super.name,
    required super.date,
    required super.distance,
    required super.duration,
    required super.totalUp,
    required super.totalDown,
    required super.coordinates,
    required super.previewImageUrl,
    this.author,
  });

  final UserProfileEntity? author;

  @override
  double get averageSpeed => distance / duration;

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
        authorId: authorId ?? this.authorId,
        name: name ?? this.name,
        date: date,
        distance: distance,
        duration: duration,
        totalUp: totalUp,
        totalDown: totalDown,
        coordinates: coordinates,
        previewImageUrl: previewImageUrl ?? this.previewImageUrl,
        author: author,
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
      };

  factory TourEntityImpl.fromJson(Map<String, dynamic> json) => TourEntityImpl(
        id: json['id'],
        authorId: json['author_id'],
        name: json['name'] as String,
        date: DateTime.parse(json['created_at'] as String),
        distance: json['distance'],
        duration: json['duration'],
        totalUp: json['totalUp'],
        totalDown: json['totalDown'],
        coordinates: (json['coordinates'] as List<dynamic>).map((e) => CoordinatesWithTimestamp.fromJson(e)).toList(),
        previewImageUrl: (json['preview_image_url'] as String),
        author: null, //TODO: CHANGE THIS TO AUTHOR PROFILE ENTITY
      );

  @override
  String get shareURL => 'https://generalmagic.com/share_tour?tour=$id';

  @override
  bool isOwn(int id) => id == authorId;

  @override
  UserProfileEntity? get authorProfile => author;
}
