import 'package:data/models/user_profile_entity_impl.dart';
import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/repositories/user_profile_repository.dart';

import 'package:openapi/openapi.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:shared/domain/user_profile_entity.dart';

class UserProfileRepositoryImpl extends UserProfileRepository {
  final Openapi _openapi;

  UserProfileRepositoryImpl(this._openapi);

  @override
  Future<UserProfileEntityImpl?> getAuthenticatedUserProfile(int userId) async {
    try {
      final result = await _openapi.getUserApi().apiUserIdGetUserGet(id: userId);

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
  Future<bool> deleteProfilePicture() async {
    try {
      final result = await _openapi.getUserApi().apiUserDeleteProfilePicturePost();
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
    final ByteData data = await rootBundle.load("assets/default_profile.png");

    return data.buffer.asUint8List();
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

  Future<int?> _getUserFriendsNumber(int userId) async {
    try {
      final result = await _openapi.getUserApi().apiUserIdFriendsNumberGet(id: userId.toString(), userId: userId);

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
    required String firstName,
    required String lastName,
    required String bio,
    required String city,
    required String country,
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
      final result = await _openapi.getUserApi().apiUserUpdateUserPut(updateUserDto: UpdateUserDto((builder) {
        builder.hasDeletedImage = hasDeletedImage;
        builder.firstName = firstName;
        builder.lastName = lastName;
        builder.city = city;
        builder.country = country;
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
