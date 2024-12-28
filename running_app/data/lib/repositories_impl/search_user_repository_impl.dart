import 'package:data/models/search_user_entity_impl.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:domain/repositories/search_users_repository.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';

class SearchUserRepositoryImpl extends SearchUsersRepository {
  final Openapi _openapi;

  SearchUserRepositoryImpl(this._openapi);

  @override
  Future<void> search({required String text, required Function(List<SearchUserEntity> p1) onResult}) async {
    try {
      final result = await _openapi.getUserApi().apiUserSearchUserGet(querry: text);

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
}
