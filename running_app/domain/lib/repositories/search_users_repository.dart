import 'package:domain/entities/search_user_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:domain/use_cases/search_users_use_case.dart';

abstract class SearchUsersRepository {
  Future<TaskProgressListener?> search(
      {required String text,
      required int userId,
      required Function(SearchStatus) onStatusUpdate,
      required Function(List<SearchUserEntity> p1) onResult});

  void cancelSearch(TaskProgressListener listener);
}
