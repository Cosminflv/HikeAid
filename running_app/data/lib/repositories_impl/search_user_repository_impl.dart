import 'dart:convert';
import 'dart:typed_data';

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
      final result = await _openapi.getUserApi().apiUserSearchUserGet(query: text);

      if (result.statusCode == 200) {
        final dtoList = result.data as BuiltList<SearchUserDto>;
        List<SearchUserEntity> users = [];

        for (final dto in dtoList) {
          users.add(SearchUserEntityImpl.fromDto(dto));

          final imageData = (await _getUserImageData(dto.id)) ?? Uint8List(3);
          users.last.imageData = imageData;
        }

        onResult(users);
      }
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<Uint8List?> _getUserImageData(int userId) async {
    try {
      final result = await _openapi.getUserApi().apiUserUserIdGetProfilePictureGet(userId: userId);

      if (result.statusCode == 200) {
        final data = result.data as String?;

        return data == null ? null : base64.decode(data);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
