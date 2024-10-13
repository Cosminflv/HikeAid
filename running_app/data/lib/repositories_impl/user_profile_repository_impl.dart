import 'dart:convert';

import 'package:data/models/user_profile_entity_impl.dart';
import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/edit_user_profile_status.dart';
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
            friendsCount: friendsNumber ?? 0);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> updateUserProfile(int id, String firstName, String lastName, String bio, Uint8List imageData,
      Function(EditUserProfileStatus p1) onUpdateProgress) async {
    onUpdateProgress(EditStarted());
    onUpdateProgress(EditInProgress());

    // Convert Uint8List imageData to Base64 string
    String base64Image = base64Encode(imageData);

    try {
      final result = await _userApi.apiUserIdPut(
          id: id.toString(),
          updateUserDto: UpdateUserDto((builder) {
            builder.id = id;
            builder.firstName = firstName;
            builder.lastName = lastName;
            builder.bio = bio;
            builder.imageData = base64Image;
          }));

      if (result.statusCode == 200) onUpdateProgress(EditSuccess());
      if (result.statusCode == 404) onUpdateProgress(EditFailed(reason: EditUserFailType.userNotFound));
      if (result.statusCode == 500) onUpdateProgress(EditFailed(reason: EditUserFailType.other));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<bool> deleteProfilePicture(int id) async {
    try {
      final result = await _userApi.apiUserIdDeleteProfilePicturePost(id: id.toString(), userId: id);
      if (result.statusCode == 200) {
        final response = result.data as bool;
        return response;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<Uint8List> fetchUserProfileImage(int id) async {
    final imageData = await _getUserImageData(id);
    return imageData ?? Uint8List(3);
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
