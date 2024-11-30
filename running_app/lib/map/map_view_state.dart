import 'package:domain/entities/camera_state_entity.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:running_app/settings/settings_view_state.dart';

class MapViewState extends Equatable {
  final bool isMapCreated;

  final bool isFollowingPosition;
  final bool isFollowPositionFixed;
  final bool isCenteredOnRoutes;

  final bool isMapInteractive;

  final double compassAngle;

  final List<RouteEntity> routes;

  final LandmarkEntity? mapSelectedLandmark;
  final RouteEntity? mapSelectedRoute;

  final MapCameraStateEntity cameraState;

  const MapViewState({
    this.isMapCreated = false,
    this.isFollowPositionFixed = false,
    this.isFollowingPosition = false,
    this.isCenteredOnRoutes = false,
    this.compassAngle = 0.0,
    this.cameraState = const MapCameraStateEntity(coordinates: CoordinatesImpl(latitude: 45, longitude: 25), zoom: 60),
    this.routes = const [],
    this.isMapInteractive = true,
    this.mapSelectedLandmark,
    this.mapSelectedRoute,
  });

  MapViewState copyWith({
    bool? isMapCreated,
    bool? isFollowPositionFixed,
    bool? isFollowingPosition,
    bool? isCenteredOnRoutes,
    double? compassAngle,
    MapCameraStateEntity? cameraState,
    bool? isMapInteractive,
    LandmarkEntity? mapSelectedLandmark,
    RouteEntity? mapSelectedRoute,
    List<RouteEntity>? routes,
  }) =>
      MapViewState(
        isMapCreated: isMapCreated ?? this.isMapCreated,
        isFollowPositionFixed: isFollowPositionFixed ?? this.isFollowPositionFixed,
        isFollowingPosition: isFollowingPosition ?? this.isFollowPositionFixed,
        isCenteredOnRoutes: isCenteredOnRoutes ?? this.isCenteredOnRoutes,
        cameraState: cameraState ?? this.cameraState,
        compassAngle: compassAngle ?? this.compassAngle,
        isMapInteractive: isMapInteractive ?? this.isMapInteractive,
        mapSelectedLandmark: mapSelectedLandmark ?? this.mapSelectedLandmark,
        mapSelectedRoute: mapSelectedRoute ?? this.mapSelectedRoute,
        routes: routes ?? this.routes,
      );

  MapViewState copyWithNullLandmark() => MapViewState(
        isMapCreated: isMapCreated,
        isFollowingPosition: isFollowingPosition,
        isFollowPositionFixed: isFollowPositionFixed,
        isCenteredOnRoutes: isCenteredOnRoutes,
        compassAngle: compassAngle,
        mapSelectedLandmark: null,
        isMapInteractive: isMapInteractive,
        mapSelectedRoute: mapSelectedRoute,
        cameraState: cameraState,
        routes: routes,
      );

  MapViewState copyWithNullRoute() => MapViewState(
        isMapCreated: isMapCreated,
        isFollowingPosition: isFollowingPosition,
        isFollowPositionFixed: isFollowPositionFixed,
        isCenteredOnRoutes: isCenteredOnRoutes,
        mapSelectedLandmark: mapSelectedLandmark,
        isMapInteractive: isMapInteractive,
        mapSelectedRoute: null,
        compassAngle: compassAngle,
        cameraState: cameraState,
        routes: const [],
      );

  @override
  List<Object?> get props => [
        isMapCreated,
        isFollowPositionFixed,
        isFollowingPosition,
        isCenteredOnRoutes,
        compassAngle,
        cameraState,
        isMapInteractive,
        mapSelectedLandmark,
        mapSelectedRoute,
        routes,
      ];
}
