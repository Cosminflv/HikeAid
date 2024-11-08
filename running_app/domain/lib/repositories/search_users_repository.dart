import 'package:dartz/dartz.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';

typedef SearchResult = Either<int, List<SearchUserEntity>>;

abstract class SearchUsersRepository {
  TaskProgressListener search({required String text, required Function(SearchResult) onResult});

  void cancelSearch(TaskProgressListener listener);
  void cancelAddressSearch(TaskProgressListener listener);
}
