import 'dart:typed_data';

import 'package:shared/domain/tour_entity.dart';
import 'package:shared/domain/tour_file_entity.dart';

abstract class TourRepository {
  Future<TourEntity?> checkForTourSharingURL();

  void registerTourSharingURLReceivedCallback(void Function(TourEntity? tour) onTourReceived);

  Future<bool> insertTour({required TourEntity tour, required Uint8List previewImageBytes});

  //Future<List<String>?> insertTourImages({required TourEntity tour, required List<TourFileEntity> images});

  Future<List<TourEntity>?> readOwnTours();

  Future<List<TourEntity>?> readTours();
  Future<List<TourFileEntity>?> readTourFiles(TourEntity tour);

  Future<void> rename({required TourEntity tour, required String newName});

  Future<void> setVisibility({required TourEntity tour, required bool isPublic});

  Future<void> delete(TourEntity tour);
}
