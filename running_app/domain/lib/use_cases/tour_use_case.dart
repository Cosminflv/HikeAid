import 'package:domain/repositories/tour_repository.dart';
import 'package:shared/domain/tour_entity.dart';

class TourUseCase {
  final TourRepository _repository;

  TourUseCase(this._repository);

  void registerTourLinkSharingCallback(void Function(TourEntity? tour) onTourReceived) =>
      _repository.registerTourSharingURLReceivedCallback(onTourReceived);

  Future<TourEntity?> checkForTourSharingURL() => _repository.checkForTourSharingURL();

  Future<TourEntity?> insertTour({required TourEntity tour}) => _repository.insertTour(tour: tour);

  // Future<List<String>?> insertTourImages({required TourEntity tour, required List<TourFileEntity> images}) =>
  //     _repository.insertTourImages(tour: tour, images: images);

  Future<List<TourEntity>?> readOwnTours() async {
    final result = <TourEntity>[];

    final tours = await _repository.readOwnTours();
    if (tours == null) return null;

    for (final tour in tours) {
      final files = await _repository.readTourFiles(tour);
      result.add(tour.copyWith(files: files));
    }

    return result;
  }

  Future<List<TourEntity>?> readTours() async {
    final result = <TourEntity>[];

    final tours = await _repository.readTours();
    if (tours == null) return null;

    for (final tour in tours) {
      final files = await _repository.readTourFiles(tour);
      result.add(tour.copyWith(files: files));
    }

    return result;
  }

  Future<void> rename({required TourEntity tour, required String newName}) =>
      _repository.rename(tour: tour, newName: newName);

  Future<void> setVisibility({required TourEntity tour, required bool isPublic}) =>
      _repository.setVisibility(tour: tour, isPublic: isPublic);

  Future<void> delete(TourEntity tour) => _repository.delete(tour);
}
