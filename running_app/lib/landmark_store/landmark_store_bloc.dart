
import 'package:core/di/injection_container.dart';
import 'package:domain/entities/landmark_store_entity.dart';
import 'package:domain/use_cases/landmark_store_use_case.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/landmark_store/landmark_store_events.dart';
import 'package:running_app/landmark_store/landmark_store_state.dart';

class LandmarkStoreBloc extends Bloc<LandmarkStoreEvent, LandmarkStoreState> {
  final _landmarkStoreUseCase = sl.get<LandmarkStoreUseCase>();

  final DLandmarkStoreType _storeType;

  LandmarkStoreBloc(this._storeType) : super(const LandmarkStoreState()) {
    on<LoadLandmarkStoreEvent>(_handleLoadStore);
    on<LandmarksUpdatedEvent>(_handleLandmarksUpdatedEvent);

    on<AddLandmarkToStoreEvent>(_handleAddLandmarkToStore);
    on<RemoveLandmarkFromStoreEvent>(_handleRemoveLandmarkFromStore);
    on<ClearStoreEvent>(_handleClearStoreEvent);

    add(LoadLandmarkStoreEvent());
  }

  _handleLoadStore(LoadLandmarkStoreEvent event, Emitter<LandmarkStoreState> emit) {
    final lmks = _landmarkStoreUseCase.getLandmarks(_storeType);

    add(LandmarksUpdatedEvent(landmarks: lmks));
  }

  _handleLandmarksUpdatedEvent(LandmarksUpdatedEvent event, Emitter<LandmarkStoreState> emit) {
    emit(state.copyWith(landmarks: event.landmarks));
  }

  _handleAddLandmarkToStore(AddLandmarkToStoreEvent event, Emitter<LandmarkStoreState> emit) {
    final currentImage = event.landmark.icon!;
    if (event.landmark.hasExtraImage) {
      event.landmark.setImage(event.landmark.extraImage!);
    }
    _landmarkStoreUseCase.addToStore(event.landmark, _storeType);

    if (event.landmark.hasExtraImage) {
      event.landmark.setImage(currentImage);
    }

    add(LoadLandmarkStoreEvent());
  }

  _handleRemoveLandmarkFromStore(RemoveLandmarkFromStoreEvent event, Emitter<LandmarkStoreState> emit) {
    _landmarkStoreUseCase.removeFromStore(event.landmark, _storeType);
    add(LoadLandmarkStoreEvent());
  }

  _handleClearStoreEvent(ClearStoreEvent event, Emitter<LandmarkStoreState> emit) {
    _landmarkStoreUseCase.clearItems(_storeType);
    add(LoadLandmarkStoreEvent());
  }
}
