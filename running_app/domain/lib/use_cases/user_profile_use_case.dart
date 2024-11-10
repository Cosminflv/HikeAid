import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/entities/user_profile_entity.dart';
import 'package:domain/repositories/user_profile_repository.dart';

import 'dart:typed_data';

class UserProfileUseCase {
  final UserProfileRepository _userProfileRepository;

  UserProfileUseCase(this._userProfileRepository);

  Future<UserProfileEntity?> getAuthenticatedUserProfile(int userId) async {
    final user = await _userProfileRepository.getAuthenticatedUserProfile(userId);
    return user;
  }

  Future<void> updateUserProfile({
    required int id,
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
    required Function(EditUserProfileStatus) onUpdateProgress,
  }) async {
    await _userProfileRepository.updateUserProfile(
        id: id,
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        imageData: imageData,
        hasDeletedImage: hasDeletedImage,
        city: city,
        conutry: country,
        weight: weight,
        birthDate: birthDate,
        age: age,
        gender: gender,
        onUpdateProgress: onUpdateProgress);
  }

  Future<void> deleteProfilePicture(int id) async {
    await _userProfileRepository.deleteProfilePicture(id);
  }

  Future<Uint8List> fetchDefaultUserProfilePicture(int id) async {
    final imageData = await _userProfileRepository.fetchDefaultUserProfileImage(id);
    return imageData;
  }
}
