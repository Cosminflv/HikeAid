import 'package:data/models/user_profile_entity_impl.dart';
import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/repositories/user_profile_repository.dart';

import 'package:openapi/openapi.dart';
import 'dart:typed_data';

class UserProfileRepositoryImpl extends UserProfileRepository {
  final UserApi _userApi;

  UserProfileRepositoryImpl(this._userApi);

  @override
  Future<UserProfileEntityImpl?> getAuthenticatedUserProfile(AuthSessionEntity session) async {
    try {
      final result = await _userApi.apiUserIdGetUserGet(id: session.user.id);

      if (result.statusCode == 200) {
        final data = result.data as Map<String, dynamic>;
        return UserProfileEntityImpl(
            id: data['id']!,
            username: data['username'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            bio: data['bio'],
            profilePicture: Uint8List(3));
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
