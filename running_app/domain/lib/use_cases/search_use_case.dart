import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:domain/repositories/search_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';

import 'package:dartz/dartz.dart';
import 'package:shared/domain/coordinates_entity.dart';

class SearchUseCase {
  final SearchRepository _searchRepository;

  int _lastSearchTimestamp;
  TaskProgressListener? _currentSearchProgressListener;

  SearchUseCase(this._searchRepository) : _lastSearchTimestamp = 0;

  search(
      {required String text,
      required CoordinatesEntity referenceCoordinates,
      required Function(Either<int, List<LandmarkWithDistanceEntity>>) onResult}) {
    _cancelActiveSearch();

    _lastSearchTimestamp = DateTime.now().millisecondsSinceEpoch;
    final currentSearchTimestamp = _lastSearchTimestamp;

    final progress = _searchRepository.search(
        text: text,
        coordinates: referenceCoordinates,
        onResult: (result) {
          if (currentSearchTimestamp < _lastSearchTimestamp) {
            return;
          }

          _currentSearchProgressListener = null;

          onResult(result);
        });

    _currentSearchProgressListener = progress;
  }

  clear() {
    _cancelActiveSearch();
  }

  _cancelActiveSearch() {
    if (_currentSearchProgressListener != null) {
      _searchRepository.cancelSearch(_currentSearchProgressListener!);
      _currentSearchProgressListener = null;
    }
  }
}
