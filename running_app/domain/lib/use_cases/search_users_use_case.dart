import 'package:dartz/dartz.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:domain/repositories/search_users_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';

enum SearchStatus { none, started, ended }

class SearchUsersUseCase {
  final SearchUsersRepository _searchUsersRepository;

  int _lastSearchTimestamp;
  TaskProgressListener? _currentSearchProgressListener;

  SearchUsersUseCase(this._searchUsersRepository) : _lastSearchTimestamp = 0;

  search({required String text, required Function(Either<int, List<SearchUserEntity>>) onResult}) {
    _cancelActiveSearch();

    _lastSearchTimestamp = DateTime.now().millisecondsSinceEpoch;
    final currentSearchTimestamp = _lastSearchTimestamp;

    final progress = _searchUsersRepository.search(
        text: text,
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
      _searchUsersRepository.cancelSearch(_currentSearchProgressListener!);
      _currentSearchProgressListener = null;
    }
  }
}
