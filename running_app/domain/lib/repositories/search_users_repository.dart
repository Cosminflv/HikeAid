import 'package:domain/entities/search_user_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';

abstract class SearchUsersRepository {
  Future<void> search(
      {required String text, required int userId, required Function(List<SearchUserEntity> p1) onResult});

  void cancelSearch(TaskProgressListener listener);
}
