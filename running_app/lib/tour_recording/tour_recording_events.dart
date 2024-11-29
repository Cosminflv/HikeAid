import 'dart:typed_data';

import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/position_entity.dart';

abstract class TourRecordingEvent {}

class UpdatePositionEvent extends TourRecordingEvent {
  final PositionEntity? position;

  UpdatePositionEvent(this.position);
}

class AddRecordedCoordinatesEvent extends TourRecordingEvent {
  final CoordinatesEntity coordinates;

  AddRecordedCoordinatesEvent(this.coordinates);
}

class StartRecordingEvent extends TourRecordingEvent {
  final bool recordGpx;

  StartRecordingEvent({this.recordGpx = true});
}

class StopRecordingEvent extends TourRecordingEvent {
  final Uint8List? tourPreview;

  StopRecordingEvent({this.tourPreview});
}

class PauseRecordingEvent extends TourRecordingEvent {}

class SaveTourEvent extends TourRecordingEvent {
  final Uint8List? preview;

  SaveTourEvent({this.preview});
}
