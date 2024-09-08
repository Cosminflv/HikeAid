import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/map/map_view_state.dart';

class MapViewBloc extends Bloc<MapViewEvent, MapViewState> {
  late MapUseCase _mapUseCase;

  MapViewBloc() : super(const MapViewState()) {
    on<InitMapViewEvent>(_initMapViewEventHandler);
  }

  _initMapViewEventHandler(InitMapViewEvent event, Emitter<MapViewState> emit) async {
    _mapUseCase = sl.get<MapUseCase>(instanceName: event.instanceName);

    _registerMapGestureCallbacks(event.isInteractive);
  }

  _registerMapGestureCallbacks(bool isInteractive) {
    _mapUseCase.setEnableTouchGestures(isInteractive);
    if (!isInteractive) return;
  }
}
