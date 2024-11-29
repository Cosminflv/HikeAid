import 'package:domain/entities/tour_entity.dart';
import 'package:domain/use_cases/tour_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/tour_recording/tour_recording_state.dart';

import 'tour_recording_events.dart';

class TourRecordingBloc extends Bloc<TourRecordingEvent, TourRecordingState> {
  DateTime _lastRecordedCoordinatesTimestamp = DateTime.now();

  final TourMetricsTracker _averageSpeedTracker = TourMetricsTracker();

  final TourUseCase _gpxUseCase;

  TourRecordingBloc(this._gpxUseCase) : super(const TourRecordingState()) {
    on<UpdatePositionEvent>(_handleUpdatePosition);
    on<AddRecordedCoordinatesEvent>(_handleAddRecordedCoordinates);
    on<StartRecordingEvent>(_handleStartRecording);
    on<StopRecordingEvent>(_handleStopRecording);
    on<PauseRecordingEvent>(_handlePauseRecording);
    on<SaveTourEvent>(_handleSaveTour);
  }

  _handleUpdatePosition(UpdatePositionEvent event, Emitter<TourRecordingState> emit) {
    if (event.position == null) return;

    if (state.status == RecordingStatus.disabled || state.status == RecordingStatus.paused) return;
    _averageSpeedTracker.addCoordinates(CoordinatesWithTimestamp.fromPosition(event.position!));

    emit(state.copyWith(
      currentSpeed: event.position!.speed,
      averageSpeed: _averageSpeedTracker.averageSpeed,
      distanceTraveled: _averageSpeedTracker.traveledDistance,
      timeInMotion: _averageSpeedTracker.timeInMotion,
    ));

    if (DateTime.now().difference(_lastRecordedCoordinatesTimestamp).inMilliseconds > 1000) {
      _lastRecordedCoordinatesTimestamp = DateTime.now();
      add(AddRecordedCoordinatesEvent(event.position!.coordinates));
    }
  }

  _handleAddRecordedCoordinates(AddRecordedCoordinatesEvent event, Emitter<TourRecordingState> emit) {
    final updatedCoords = [...state.recordedCoordinates, event.coordinates];
    emit(state.copyWith(recordedCoordinates: updatedCoords));
  }

  _handleStartRecording(StartRecordingEvent event, Emitter<TourRecordingState> emit) async {
    _averageSpeedTracker.reset();
    emit(state.copyWithNullMetrics(status: RecordingStatus.enabled));

    if (event.recordGpx) await _gpxUseCase.startRecording();
  }

  _handleStopRecording(StopRecordingEvent event, Emitter<TourRecordingState> emit) async =>
      emit(state.copyWith(status: RecordingStatus.disabled));

  _handlePauseRecording(PauseRecordingEvent event, Emitter<TourRecordingState> emit) =>
      emit(state.copyWith(status: RecordingStatus.paused));

  _handleSaveTour(SaveTourEvent event, Emitter<TourRecordingState> emit) async {
    final tour = await _gpxUseCase.stopRecording(preview: event.preview);
    if (tour == null) return;

    emit(state.copyWith(status: RecordingStatus.tourSaved, tour: tour.copyWith(duration: state.timeInMotion)));
  }
}

class TourMetricsTracker {
  double _totalDistance = 0;
  Duration _totalTime = Duration(seconds: 0); // Only time in motion
  double? _averageSpeed;
  CoordinatesWithTimestamp? _lastCoordinate;
  bool _isPaused = false;

  // Set thresholds for significant movement
  final double minDistanceThreshold = 1.0; // meters
  final Duration minTimeThreshold = const Duration(seconds: 1); // seconds
  final Duration maxTimeThreshold = const Duration(seconds: 5); // Exclude large time gaps

  // Reset the tracker state
  void reset() {
    _totalDistance = 0;
    _totalTime = const Duration(seconds: 0);
    _averageSpeed = null;
    _lastCoordinate = null;
    _isPaused = false;
  }

  // Pause tracking
  void pause() {
    _isPaused = true;
  }

  // Resume tracking
  void resume() {
    _isPaused = false;
    _lastCoordinate = null; // Reset the last coordinate to avoid time discrepancies
  }

  // Add a new position
  void addCoordinates(CoordinatesWithTimestamp coordinate) {
    if (_isPaused) return;

    if (_lastCoordinate == null) {
      _lastCoordinate = coordinate;
      return;
    }

    double distance = _lastCoordinate!.latLng.getDistanceTo(coordinate.latLng);
    double timeDifference = coordinate.timestamp.difference(_lastCoordinate!.timestamp).inSeconds.toDouble();

    if (coordinate.timestamp.difference(_lastCoordinate!.timestamp) > maxTimeThreshold) {
      _lastCoordinate = coordinate;
      return;
    }

    if (distance >= minDistanceThreshold &&
        coordinate.timestamp.difference(_lastCoordinate!.timestamp) >= minTimeThreshold) {
      _totalDistance += distance;
      _totalTime += Duration(seconds: timeDifference.toInt());

      _lastCoordinate = coordinate;

      _averageSpeed = _calculateAverageSpeed();
    }
  }

  double? _calculateAverageSpeed() {
    if (_totalTime.inSeconds == 0) {
      return null;
    }
    return _totalDistance / _totalTime.inSeconds;
  }

  double? get averageSpeed => _averageSpeed;
  int get traveledDistance => _totalDistance.toInt();
  int get timeInMotion => _totalTime.inSeconds;
}
