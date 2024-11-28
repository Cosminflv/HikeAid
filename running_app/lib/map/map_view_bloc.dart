import 'package:core/di/injection_container.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/repositories/camera_repository.dart';
import 'package:domain/use_cases/landmark_use_case.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/entities/asset_bundle_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/utils/assets_utils.dart';
import 'package:running_app/utils/debouncer.dart';
import 'package:running_app/utils/sizes.dart';
import 'package:running_app/map/map_view_state.dart';

import 'dart:async';
import 'dart:typed_data';

class MapViewBloc extends Bloc<MapViewEvent, MapViewState> {
  late MapUseCase _mapUseCase;
  late LandmarkUseCase _landmarkUseCase;

  late Uint8List? _pinImage;

  final AssetBundleEntity _assetBundleEntity;

  Timer? _debounce;
  final Debouncer _debouncer = Debouncer(milliseconds: 100);

  PointEntity<double> Function()? _getCenterOfVisibleArea;

  MapViewBloc(this._assetBundleEntity) : super(const MapViewState()) {
    on<InitMapViewEvent>(_initMapViewEventHandler);

    on<CompassAlignNorthEvent>(_handleAlignNorth);
    on<CompassAngleUpdatedEvent>(_handleCompassAngleUpdated);
    on<CompassLockCameraEvent>(_handleCompassLockCamera);

    on<FollowPositionEvent>(_followPositionEventHandler);
    on<ResetCameraEvent>(_handleResetCamera);
    on<CenterOnRoutesEvent>(_handleCenterOnRoutes);

    on<SelectedLandmarkUpdatedEvent>(_selectedLandmarkUpdatedEventHandler);
    on<PresentHighlightEvent>(_handlePresentHighlightEvent);
    on<RemoveHighlightsEvent>(_handleRemoveHighlights);

    on<SelectedRouteUpdatedEvent>(_handleSelectedRouteUpdated);
    on<PresentRoutesEvent>(_handlePresentRoutes);
    on<RemoveAllRoutesEvent>(_handleRemoveAllRoutes);
    on<RemoveRoutesEvent>(_handleRemoveRoutes);
    on<RemoveAllRoutesExceptEvent>(_handleRemoveAllRouteExcept);
    on<RemoveRoutesExceptMainEvent>(_handleRemoveRoutesExceptMainEvent);
    on<RemoveAllHighlightsEvent>(_handleRemoveAllHighlights);

    on<CameraStateUpdatedEvent>(_handleCameraStateUpdated);
  }

  _initMapViewEventHandler(InitMapViewEvent event, Emitter<MapViewState> emit) async {
    _landmarkUseCase = sl.get<LandmarkUseCase>();
    _mapUseCase = sl.get<MapUseCase>(instanceName: event.instanceName);

    _getCenterOfVisibleArea = event.centerOfVisibleAreaFunction;

    _registerMapGestureCallbacks(event.isInteractive);

    _setupPositionTracker(true);
    await _loadImages();
  }

  _handleAlignNorth(CompassAlignNorthEvent event, Emitter<MapViewState> emit) {
    _mapUseCase.alignCompassNorth();
    emit(state.copyWith(isFollowPositionFixed: false, isFollowingPosition: false));
  }

  _handleCompassAngleUpdated(CompassAngleUpdatedEvent event, Emitter<MapViewState> emit) {
    emit(state.copyWith(compassAngle: event.angle, isFollowingPosition: state.isFollowingPosition));
  }

  _handleCompassLockCamera(CompassLockCameraEvent event, Emitter<MapViewState> emit) {
    _mapUseCase.setFollowPositionPreferences(
        mode: state.isFollowPositionFixed
            ? DFollowPositionRotationMode.fixed
            : DFollowPositionRotationMode.positionHeading);
    emit(state.copyWith(isFollowPositionFixed: !state.isFollowPositionFixed));
  }

  _followPositionEventHandler(FollowPositionEvent event, Emitter<MapViewState> emit) async {
    int zoom = event.shouldZoomCamera ? 80 : 70;
    final angle = event.shouldTiltCamera ? 60.0 : 0.0;

    PointEntity<double> pointToCenter = _getCenterOfVisibleArea!();
    _mapUseCase.startFollowPosition(
      zoom: zoom,
      viewAngle: angle,
      onComplete: () {
        if (isClosed) return;
        add(CameraStateUpdatedEvent());
      },
      pointToCenter: pointToCenter,
    );

    emit(state.copyWith(isFollowingPosition: true, isCenteredOnRoutes: false));
  }

  _handleResetCamera(ResetCameraEvent event, Emitter<MapViewState> emit) =>
      emit(state.copyWith(isFollowingPosition: false, isFollowPositionFixed: false));

  _handleCenterOnRoutes(CenterOnRoutesEvent event, Emitter<MapViewState> emit) {
    emit(state.copyWith(isFollowingPosition: false, isCenteredOnRoutes: true));

    _mapUseCase.centerOnMapRoutes(event.viewArea ?? Sizes.routesDisplayAreaMode, true, true);
  }

  _selectedLandmarkUpdatedEventHandler(SelectedLandmarkUpdatedEvent event, Emitter<MapViewState> emit) async {
    if (state.mapSelectedLandmark != null) _mapUseCase.removeHighlights(_toShortRange(state.mapSelectedLandmark!.id));
    if (event.landmark == null) {
      emit(state.copyWithNullLandmark());

      if (event.coordinates != null) {
        final landmark = _landmarkUseCase.getLandmarkAtCoordinates(
            coordinates: event.coordinates!,
            name: event.name ?? '${event.coordinates!.latitude.toString()} ${event.coordinates!.longitude.toString()}');
        add(SelectedLandmarkUpdatedEvent(landmark: landmark, forceCenter: event.forceCenter));
      }
      return;
    }
    emit(state.copyWith(mapSelectedLandmark: event.landmark));
  }

  _handlePresentHighlightEvent(PresentHighlightEvent event, Emitter<MapViewState> emit) async {
    _mapUseCase.presentHighlight(event.landmark,
        highlightId: _toShortRange(event.landmark.id),
        showLabel: event.showLabel,
        image: event.isPin ? _pinImage : event.image);

    if (event.screenPosition != null) {
      _mapUseCase.centerOnCoordinates(
          coordinates: event.landmark.coordinates, screenPosition: event.screenPosition!, zoom: 70);
      emit(state.copyWith(isFollowingPosition: false));
    }
  }

  _handleRemoveHighlights(RemoveHighlightsEvent event, Emitter<MapViewState> emit) {
    _mapUseCase.removeHighlights(_toShortRange(event.highlightId));
  }

  _defaultLandmarkRouteTapPriorityFunction(LandmarkEntity landmark) => false;

  _registerMapGestureCallbacks(
    bool isInteractive,
  ) {
    _mapUseCase.setEnableTouchGestures(isInteractive);
    if (!isInteractive) return;

    _mapUseCase.registerMapGestureCallbacks(onMapAngleUpdated: (angle) {
      if (isClosed) return;
      add(CompassAngleUpdatedEvent(angle));
    }, onMapMove: () {
      if (isClosed) return;
      add(ResetCameraEvent());
      _debouncer.run(() {
        if (isClosed) return;
        add(CameraStateUpdatedEvent());
      });
    }, onTap: (selectedLandmark, selectedRoute) {
      if (selectedLandmark != null && selectedRoute != null) {
        final landmarkTestMethod = _defaultLandmarkRouteTapPriorityFunction;

        if (landmarkTestMethod(selectedLandmark)) {
          add(SelectedLandmarkUpdatedEvent(landmark: selectedLandmark, forceCenter: true));
        } else {
          add(SelectedRouteUpdatedEvent(selectedRoute));
        }
      } else {
        if (selectedLandmark != null) {
          add(SelectedLandmarkUpdatedEvent(landmark: selectedLandmark, forceCenter: true));
        }
        if (selectedRoute != null) {
          add(SelectedRouteUpdatedEvent(selectedRoute));
        }
      }
    });
  }

  _handleSelectedRouteUpdated(SelectedRouteUpdatedEvent event, Emitter<MapViewState> emit) async {
    if (state.routes.isEmpty) {
      return;
    }
    final selectedRoute = event.route;

    final mainRoute = state.routes.firstWhere((element) => element.equals(selectedRoute));

    _mapUseCase.setMainRoute(mainRoute);

    if (isClosed) return;
    emit(state.copyWith(mapSelectedRoute: mainRoute));
  }

  _handlePresentRoutes(PresentRoutesEvent event, Emitter<MapViewState> emit) async {
    _mapUseCase.presentRoutes(event.routes, hasLabel: event.hasLabel);

    if (event.routes.isNotEmpty) {
      emit(state.copyWith(mapSelectedRoute: event.routes.first, routes: event.routes));
    }
    if (event.shouldCenter == false) return;
    await Future.delayed(const Duration(milliseconds: 200));
    add(CenterOnRoutesEvent(viewArea: event.viewArea));
  }

  _handleRemoveAllRoutes(RemoveAllRoutesEvent event, Emitter<MapViewState> emit) {
    _mapUseCase.removeRoutes();
    emit(state.copyWithNullRoute());
  }

  _handleRemoveRoutes(RemoveRoutesEvent event, Emitter<MapViewState> emit) {
    for (final route in event.routes) {
      _mapUseCase.removeRoute(route);
    }
  }

  _handleRemoveAllRouteExcept(RemoveAllRoutesExceptEvent event, Emitter<MapViewState> emit) {
    _mapUseCase.removeRoutesExcept(event.routes);
  }

  _handleRemoveRoutesExceptMainEvent(RemoveRoutesExceptMainEvent event, Emitter<MapViewState> emit) {
    _mapUseCase.clearAllButMainRoute();
  }

  _handleRemoveAllHighlights(RemoveAllHighlightsEvent event, Emitter<MapViewState> emit) {
    if (event.removeFromMap) {
      _mapUseCase.clearHighlights();
    }
    if (event.removeFromState) {
      emit(state.copyWithNullLandmark());
    }
  }

  _handleCameraStateUpdated(CameraStateUpdatedEvent event, Emitter<MapViewState> emit) =>
      emit(state.copyWith(cameraState: _mapUseCase.getCameraState()));

  Future<void> _setupPositionTracker(bool isPositionTrackerVisible) async {
    final String filePath;

    isPositionTrackerVisible ? filePath = 'assets/positionTracker.png' : filePath = 'assets/empty.glb';

    final bytes = await _assetBundleEntity.loadAsUint8List(filePath);
    _mapUseCase.setPositionTrackerImage(bytes, scale: 0.5);
  }

  void debounce(Function() action, {Duration duration = const Duration(milliseconds: 300)}) {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }
    _debounce = Timer(duration, action);
  }

  int _toShortRange(int hash) {
    const int shortMin = 0;
    const int shortMax = 32767;

    int range = shortMax - shortMin + 1;
    int normalizedHash = hash % range + shortMin;

    if (normalizedHash < shortMin) {
      normalizedHash += range;
    }
    return normalizedHash;
  }

  Future<void> _loadImages() async {
    _pinImage = await assetToUint8List('assets/map_pin.png');
  }
}
