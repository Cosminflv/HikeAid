import 'dart:typed_data';

import 'package:shared/domain/tour_entity.dart';

abstract class TourRepository {
  Future<bool> insertTour({required TourEntity tour, required Uint8List previewImageBytes});

  Future<List<TourEntity>?> readTours(int userId);

  Future<void> rename({required TourEntity tour, required String newName});

  Future<void> delete(TourEntity tour);
}
