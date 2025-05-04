import 'package:domain/entities/camera_state_entity.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:equatable/equatable.dart';

class CoordinatesImpl extends CoordinatesEntity {
  const CoordinatesImpl({required super.latitude, required super.longitude});

  @override
  double getDistanceTo(CoordinatesEntity coords) => throw UnimplementedError();
}

class SettingsViewState extends Equatable {
  final String prefferedMapStylePath;

  final MapCameraStateEntity savedCameraState;
  final bool isInitialized;

  const SettingsViewState({
    this.prefferedMapStylePath = '',
    this.isInitialized = false,
    this.savedCameraState = const MapCameraImpl(
      coordinates: CoordinatesImpl(latitude: 40.787372133491466, longitude: -74.13349856151378),
      zoom: 40,
      isFollowingPositon: false,
    ),
  });

  SettingsViewState copyWith({
    bool? hasChangedSettings,
    bool? isInitialized,
    MapCameraStateEntity? savedCameraState,
    String? prefferedMapStylePath,
  }) {
    return SettingsViewState(
        prefferedMapStylePath: prefferedMapStylePath ?? this.prefferedMapStylePath,
        savedCameraState: savedCameraState ?? this.savedCameraState,
        isInitialized: isInitialized ?? this.isInitialized,
      );
  }

  @override
  List<Object?> get props => [
        savedCameraState,
        prefferedMapStylePath,
        isInitialized,
      ];
}

class MapCameraImpl extends MapCameraStateEntity {
  const MapCameraImpl({
    required super.coordinates,
    required super.zoom,
    super.isFollowingPositon = false,
  });
}
