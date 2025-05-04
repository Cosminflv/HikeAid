import 'package:domain/entities/camera_state_entity.dart';
import 'package:shared/data/coordinates_entity_impl.dart';

class MapCameraStateEntityImpl extends MapCameraStateEntity {
  MapCameraStateEntityImpl({
    required super.coordinates,
    required super.zoom,
    required super.isFollowingPositon,
  });

  Map<String, dynamic> toJson() => {
        'coordinates': (coordinates as CoordinatesEntityImpl).toJson(),
        'zoomLevel': zoom,
        'isFollowingPosition': isFollowingPositon,
      };

  static MapCameraStateEntity fromJson(Map<String, dynamic> json) => MapCameraStateEntityImpl(
        coordinates: CoordinatesEntityImpl.fromJson(json['coordinates']),
        zoom: json['zoomLevel'],
        isFollowingPositon: json['isFollowingPosition'] ?? false,
      );
}
