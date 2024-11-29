import 'dart:typed_data';

import 'package:domain/entities/tour_entity.dart';

abstract class TourRepository {
  Future<void> startRecording();

  Future<TourEntity?> stopRecording({Uint8List? preview});

  // Future<void> addTourPreview({required TourEntity tour, required Uint8List preview});

  Future<List<TourEntity>> getRecordedTours();

  // Future<void> delete(TourEntity tour);

  // Future<void> rename({required TourEntity tour, required String newName});

  // Future<void> shareAsGPX(TourEntity tour);

  // Future<void> saveTour(TourEntity tour);

  // Future<TourEntity?> importTour();

  // void registerForIncomingGPXIntents(void Function(TourEntity tour) onTourReceived);

  // Future<TourEntity?> addPlannedTour(RouteEntity route, String name);
  // Future<List<TourEntity>> getPlannedTours();
}
