import 'dart:typed_data';

import 'package:domain/repositories/tour_repository.dart';
import 'package:shared/domain/tour_entity.dart';

class TourUseCase {
  final TourRepository _repository;

  TourUseCase(this._repository);

  Future<bool> insertTour({required TourEntity tour, required Uint8List previewImageBytes}) =>
      _repository.insertTour(tour: tour, previewImageBytes: previewImageBytes);

  Future<List<TourEntity>?> readTours(int userId) async => await _repository.readTours(userId);

  Future<void> rename({required TourEntity tour, required String newName}) =>
      _repository.rename(tour: tour, newName: newName);

  Future<void> delete(TourEntity tour) => _repository.delete(tour);
}
