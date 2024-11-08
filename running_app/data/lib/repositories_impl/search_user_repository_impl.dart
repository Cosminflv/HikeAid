import 'package:domain/repositories/search_users_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';

class SearchUserRepositoryImpl extends SearchUsersRepository {
  @override
  void cancelAddressSearch(TaskProgressListener listener) {
    // TODO: implement cancelAddressSearch
  }

  @override
  void cancelSearch(TaskProgressListener listener) {
    // TODO: implement cancelSearch
  }

  @override
  TaskProgressListener search({required String text, required Function(SearchResult p1) onResult}) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
