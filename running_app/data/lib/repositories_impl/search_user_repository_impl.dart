import 'package:data/models/search_user_entity_impl.dart';
import 'package:data/models/task_progress_listener_impl.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:domain/repositories/search_users_repository.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';

class SearchUserRepositoryImpl extends SearchUsersRepository {
  final Openapi _openapi;

  SearchUserRepositoryImpl(this._openapi);

  @override
  void cancelSearch(TaskProgressListener listener) {
    final listenerImpl = listener as TaskProgressListenerImpl;

    listenerImpl.shouldCancel = true;
  }

  @override
  Future<TaskProgressListener?> search(
      {required String text, required int userId, required Function(List<SearchUserEntity> p1) onResult}) async {
    try {
      final progress = TaskProgressListenerImpl();
      final result = await _openapi.getUserApi().apiUserSearchUserGet(querry: text, userSearchingId: userId);

      if (result.statusCode == 200) {
        final dtoList = result.data as BuiltList<SearchUserDto>;
        final List<SearchUserEntity> users = [];

        for (final dto in dtoList) {
          users.add(SearchUserEntityImpl.fromDto(dto));
        }

        onResult(users);
      }
      return progress;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
