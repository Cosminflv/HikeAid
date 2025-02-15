import 'package:core/di/injection_container.dart';
import 'package:domain/entities/landmark_entity.dart';
import 'package:domain/entities/path_entity.dart';
import 'package:domain/entities/tour_entity.dart';
import 'package:domain/factories/landmark_factory.dart';
import 'package:domain/factories/path_factory.dart';
import 'package:equatable/equatable.dart';

enum RecordingStatus {
  disabled,
  enabled,
  paused,
  tourSaved,
}

class TourRecordingState extends Equatable {
  final RecordingStatus status;
  final double? currentSpeed;
  final double? averageSpeed;
  final int? distanceTraveled;
  final int? timeInMotion;

  final List<CoordinatesWithTimestamp> recordedCoordinates;
  final TourEntity? tour;

  bool get isValidTour =>
      (distanceTraveled != null && distanceTraveled != 0) && (timeInMotion != null && timeInMotion != 0);

  LandmarkEntity? get startLandmark =>
      recordedCoordinates.isNotEmpty ? sl.get<LandmarkFactory>().produce(recordedCoordinates.first.latLng) : null;

  LandmarkEntity? get endLandmark =>
      recordedCoordinates.isNotEmpty ? sl.get<LandmarkFactory>().produce(recordedCoordinates.last.latLng) : null;

  PathEntity? get recordedPath => recordedCoordinates.isNotEmpty
      ? sl.get<PathFactory>().produce(recordedCoordinates.map((e) => e.latLng).toList())
      : null;

  const TourRecordingState({
    this.status = RecordingStatus.disabled,
    this.currentSpeed,
    this.averageSpeed,
    this.distanceTraveled,
    this.timeInMotion,
    this.recordedCoordinates = const [],
    this.tour,
  });

  TourRecordingState copyWith({
    RecordingStatus? status,
    double? currentSpeed,
    double? averageSpeed,
    int? distanceTraveled,
    int? timeInMotion,
    List<CoordinatesWithTimestamp>? recordedCoordinates,
    TourEntity? tour,
  }) =>
      TourRecordingState(
        status: status ?? this.status,
        currentSpeed: currentSpeed ?? this.currentSpeed,
        averageSpeed: averageSpeed ?? this.averageSpeed,
        distanceTraveled: distanceTraveled ?? this.distanceTraveled,
        timeInMotion: timeInMotion ?? this.timeInMotion,
        recordedCoordinates: recordedCoordinates ?? this.recordedCoordinates,
        tour: tour ?? this.tour,
      );

  TourRecordingState copyWithNullMetrics({RecordingStatus? status}) => TourRecordingState(
        status: status ?? this.status,
        recordedCoordinates: const [],
        currentSpeed: null,
        averageSpeed: null,
        distanceTraveled: null,
        timeInMotion: null,
        tour: null,
      );

  @override
  List<Object?> get props => [
        status,
        currentSpeed,
        averageSpeed,
        distanceTraveled,
        timeInMotion,
        recordedCoordinates,
        tour,
      ];
}
