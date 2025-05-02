import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/repositories/user_profile_repository.dart';
import 'package:shared/domain/tour_entity.dart';

import 'dart:typed_data';

import 'package:shared/domain/user_profile_entity.dart';

class UserProfileUseCase {
  final UserProfileRepository _userProfileRepository;

  UserProfileUseCase(this._userProfileRepository);

  Future<UserProfileEntity?> getUserProfile(int userId) async {
    final user = await _userProfileRepository.getAuthenticatedUserProfile(userId);
    return user;
  }

  Future<List<TourEntity>> getUserTours(int userId) async {
    final tours = await _userProfileRepository.getUserTours(userId);
    return tours;
  }

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
    required Function(EditUserProfileStatus) onUpdateProgress,
  }) async {
    await _userProfileRepository.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        imageData: imageData,
        hasDeletedImage: hasDeletedImage,
        city: city,
        country: country,
        weight: weight,
        birthDate: birthDate,
        age: age,
        gender: gender,
        onUpdateProgress: onUpdateProgress);
  }

  Future<void> deleteProfilePicture() async {
    await _userProfileRepository.deleteProfilePicture();
  }

  Future<Uint8List> fetchDefaultUserProfilePicture(int id) async {
    final imageData = await _userProfileRepository.fetchDefaultUserProfileImage(id);
    return imageData;
  }
}
