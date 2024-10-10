import 'dart:convert';

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
        final userId = data['id'];

        final imageData = await _getUserImageData(userId);
        final friendsNumber = await _getUserFriendsNumber(userId);

        return UserProfileEntityImpl(
            id: data['id']!,
            username: data['username'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            bio: data['bio'],
            imageData: imageData ?? Uint8List(3),
            friendsCount: friendsNumber);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Uint8List?> _getUserImageData(int userId) async {
    try {
      final result = await _userApi.apiUserIdGetProfilePictureGet(id: userId.toString(), userId: userId);

      if (result.statusCode == 200) {
        final data = result.data;

        return data == null ? null : base64.decode(data);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int?> _getUserFriendsNumber(int userId) async {
    try {
      final result = await _userApi.apiUserIdFriendsNumberGet(id: userId.toString(), userId: userId);

      if (result.statusCode == 200) {
        final data = result.data;

        return data;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
