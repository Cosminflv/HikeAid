import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/landmark_use_case.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/map/map_view_state.dart';

import 'package:domain/entities/view_area_entity.dart';

class MapViewBloc extends Bloc<MapViewEvent, MapViewState> {
  late MapUseCase _mapUseCase;
  late LandmarkUseCase _landmarkUseCase;

  PointEntity<double> Function()? _getCenterOfVisibleArea;

  MapViewBloc() : super(const MapViewState()) {
    on<InitMapViewEvent>(_initMapViewEventHandler);
    on<FollowPositionEvent>(_followPositionEventHandler);

    on<SelectedLandmarkUpdatedEvent>(_selectedLandmarkUpdatedEventHandler);

    on<CameraStateUpdatedEvent>(_handleCameraStateUpdated);
  }

  _initMapViewEventHandler(InitMapViewEvent event, Emitter<MapViewState> emit) async {
    _landmarkUseCase = sl.get<LandmarkUseCase>();
    _mapUseCase = sl.get<MapUseCase>(instanceName: event.instanceName);

    _getCenterOfVisibleArea = event.centerOfVisibleAreaFunction;

    _registerMapGestureCallbacks(event.isInteractive);
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
  }

  _selectedLandmarkUpdatedEventHandler(SelectedLandmarkUpdatedEvent event, Emitter<MapViewState> emit) async {
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

  _registerMapGestureCallbacks(bool isInteractive) {
    _mapUseCase.setEnableTouchGestures(isInteractive);
    if (!isInteractive) return;
  }

  _handleCameraStateUpdated(CameraStateUpdatedEvent event, Emitter<MapViewState> emit) =>
      emit(state.copyWith(cameraState: _mapUseCase.getCameraState()));
}
