import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';

abstract class LandmarkStoreEvent {}

class AddLandmarkToStoreEvent extends LandmarkStoreEvent {
  final LandmarkEntity landmark;
  final CoordinatesEntity? currentCoordinates;

  AddLandmarkToStoreEvent({required this.landmark, this.currentCoordinates});
}

class LoadLandmarkStoreEvent extends LandmarkStoreEvent {
  LoadLandmarkStoreEvent();
}

class LandmarksUpdatedEvent extends LandmarkStoreEvent {
  final List<LandmarkEntity> landmarks;

  LandmarksUpdatedEvent({required this.landmarks});
}

class ClearStoreEvent extends LandmarkStoreEvent {
  ClearStoreEvent();
}

class RemoveLandmarkFromStoreEvent extends LandmarkStoreEvent {
  final LandmarkEntity landmark;

  RemoveLandmarkFromStoreEvent(this.landmark);
}
