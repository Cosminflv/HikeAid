import 'package:data/models/search_user_entity_impl.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:domain/repositories/search_users_repository.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';

class SearchUserRepositoryImpl extends SearchUsersRepository {
  final Openapi _openapi;

  SearchUserRepositoryImpl(this._openapi);

  @override
  Future<void> search(
      {required String text, required int userId, required Function(List<SearchUserEntity> p1) onResult}) async {
    try {
      final result = await _openapi.getUserApi().apiUserSearchUserGet(querry: text, userSearchingId: userId);

      if (result.statusCode == 200) {
        final dtoList = result.data as BuiltList<SearchUserDto>;
        final List<SearchUserEntity> users = [];

        for (final dto in dtoList) {
          users.add(SearchUserEntityImpl.fromDto(dto));
        }

        onResult(users);
      }
    } catch (e) {
      print(e);
      return;
    }
  }

  @override
  Future<void> sendFriendRequest({required int requesterId, required int receiverId}) async {
    try {
      await _openapi.getUserApi().apiUserSendFriendRequestPost(requesterId: requesterId, receiverId: receiverId);
    } catch (e) {
      print(e);
      return;
    }
  }
}
