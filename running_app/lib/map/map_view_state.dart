import 'package:domain/entities/camera_state_entity.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:equatable/equatable.dart';

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
  final CoordinatesEntity? mapSelectedAlertCoords;

  final MapCameraStateEntity? cameraState;

  const MapViewState(
      {this.isMapCreated = false,
      this.isFollowPositionFixed = false,
      this.isFollowingPosition = false,
      this.isCenteredOnRoutes = false,
      this.compassAngle = 0.0,
      this.cameraState,
      this.routes = const [],
      this.isMapInteractive = true,
      this.mapSelectedLandmark,
      this.mapSelectedRoute,
      this.mapSelectedAlertCoords});

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
    CoordinatesEntity? mapSelectedAlertCoords,
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
        mapSelectedAlertCoords: mapSelectedAlertCoords ?? this.mapSelectedAlertCoords,
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
        mapSelectedAlertCoords: mapSelectedAlertCoords,
        cameraState: cameraState,
        routes: routes,
      );

  MapViewState copyWithNullRoute() => MapViewState(
        isMapCreated: isMapCreated,
        isFollowingPosition: isFollowingPosition,
        isFollowPositionFixed: isFollowPositionFixed,
        isCenteredOnRoutes: isCenteredOnRoutes,
        mapSelectedLandmark: mapSelectedLandmark,
        mapSelectedAlertCoords: mapSelectedAlertCoords,
        isMapInteractive: isMapInteractive,
        mapSelectedRoute: null,
        compassAngle: compassAngle,
        cameraState: cameraState,
        routes: const [],
      );

  MapViewState copyWithNullAlert() => MapViewState(
        isMapCreated: isMapCreated,
        isFollowingPosition: isFollowingPosition,
        isFollowPositionFixed: isFollowPositionFixed,
        isCenteredOnRoutes: isCenteredOnRoutes,
        compassAngle: compassAngle,
        mapSelectedLandmark: mapSelectedLandmark,
        isMapInteractive: isMapInteractive,
        mapSelectedRoute: mapSelectedRoute,
        mapSelectedAlertCoords: null,
        cameraState: cameraState,
        routes: routes,
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
        mapSelectedAlertCoords,
        routes,
      ];
}
