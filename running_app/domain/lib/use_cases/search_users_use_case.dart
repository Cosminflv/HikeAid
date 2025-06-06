import 'package:domain/entities/search_user_entity.dart';
import 'package:domain/repositories/search_users_repository.dart';

class SearchUsersUseCase {
  final SearchUsersRepository _searchUsersRepository;

  int _lastSearchTimestamp;

  SearchUsersUseCase(this._searchUsersRepository) : _lastSearchTimestamp = 0;

  search({required String text, required Function(List<SearchUserEntity>) onResult}) async {
    _lastSearchTimestamp = DateTime.now().millisecondsSinceEpoch;
    final currentSearchTimestamp = _lastSearchTimestamp;

    await _searchUsersRepository.search(
        text: text,
        onResult: (result) {
          if (currentSearchTimestamp < _lastSearchTimestamp) {
            return;
          }
          onResult(result);
        });
  }
}
