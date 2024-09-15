import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:running_app/settings/settings_view_state.dart';

class MapViewState extends Equatable {
  final bool isMapCreated;

  final bool isFollowingPosition;
  final bool isFollowPositionFixed;

  final LandmarkEntity? mapSelectedLandmark;

  final MapCameraStateEntity cameraState;

  const MapViewState({
    this.isMapCreated = false,
    this.isFollowPositionFixed = false,
    this.isFollowingPosition = false,
    this.cameraState = const MapCameraStateEntity(coordinates: CoordinatesImpl(latitude: 45, longitude: 25), zoom: 60),
    this.mapSelectedLandmark,
  });

  MapViewState copyWith({
    bool? isMapCreated,
    bool? isFollowPositionFixed,
    bool? isFollowingPosition,
    MapCameraStateEntity? cameraState,
    LandmarkEntity? mapSelectedLandmark,
  }) =>
      MapViewState(
        isMapCreated: isMapCreated ?? this.isMapCreated,
        isFollowPositionFixed: isFollowPositionFixed ?? this.isFollowPositionFixed,
        isFollowingPosition: isFollowingPosition ?? this.isFollowPositionFixed,
        cameraState: cameraState ?? this.cameraState,
        mapSelectedLandmark: mapSelectedLandmark ?? this.mapSelectedLandmark,
      );

  MapViewState copyWithNullLandmark() => MapViewState(
        isMapCreated: isMapCreated,
        isFollowingPosition: isFollowingPosition,
        isFollowPositionFixed: isFollowPositionFixed,
        mapSelectedLandmark: null,
        cameraState: cameraState,
      );

  @override
  List<Object?> get props => [
        isMapCreated,
        isFollowPositionFixed,
        isFollowingPosition,
      ];
}
