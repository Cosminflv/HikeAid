import 'dart:convert';

import 'package:data/models/user_profile_entity_impl.dart';
import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/entities/user_profile_entity.dart';
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

        final imageData = await _getUserImageData(userId, false);
        final friendsNumber = await _getUserFriendsNumber(userId);

        return UserProfileEntityImpl(
            id: data['id']!,
            username: data['username'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            bio: data['bio'],
            gender: EGenderEntity.values[data['gender']],
            age: data['age'],
            city: data['city'],
            country: data['country'],
            weight: data['weight'],
            birthDate: DateTime.parse(data['birthDate']),
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
  Future<Uint8List> fetchDefaultUserProfileImage(int id) async {
    final imageData = await _getUserImageData(id, true);
    return imageData ?? Uint8List(3);
  }

  Future<Uint8List?> _getUserImageData(int userId, bool defaultImage) async {
    try {
      final result = defaultImage
          ? await _userApi.getDefaultProfilePictureGet()
          : await _userApi.apiUserIdGetProfilePictureGet(id: userId.toString(), userId: userId);

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

  @override
  Future<void> updateUserProfile({
    required int id,
    required String firstName,
    required String lastName,
    required String bio,
    required String city,
    required String conutry,
    required int age,
    required int weight,
    required EGenderEntity gender,
    required DateTime birthDate,
    required Uint8List imageData,
    required bool hasDeletedImage,
    required Function(EditUserProfileStatus p1) onUpdateProgress,
  }) async {
    onUpdateProgress(EditStarted());
    onUpdateProgress(EditInProgress());

    // Convert Uint8List imageData to Base64 string
    String base64Image = base64Encode(imageData);

    try {
      final result = await _userApi.apiUserIdPut(
          id: id.toString(),
          updateUserDto: UpdateUserDto((builder) {
            builder.hasDeletedImage = hasDeletedImage;
            builder.id = id;
            builder.firstName = firstName;
            builder.lastName = lastName;
            builder.city = city;
            builder.country = conutry;
            builder.age = age;
            builder.birthDate = DateTime.utc(birthDate.year, birthDate.month, birthDate.day);
            builder.weight = weight;
            builder.gender = gender.index == 0 ? EGender.number0 : EGender.number1;
            builder.bio = bio;
            builder.imageData = base64Image;
          }));

      switch (result.statusCode) {
        case 200:
          onUpdateProgress(EditSuccess());
          break;
        case 404:
          onUpdateProgress(EditFailed(reason: EditUserFailType.userNotFound));
          break;
        case 408:
          onUpdateProgress(EditFailed(reason: EditUserFailType.timeout));
          break;
        case 500:
          onUpdateProgress(EditFailed(reason: EditUserFailType.other));

        default:
          onUpdateProgress(EditFailed(reason: EditUserFailType.other));
      }
    } catch (e) {
      print(e);
    }
  }
}
