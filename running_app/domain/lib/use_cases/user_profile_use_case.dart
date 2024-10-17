import 'dart:typed_data';

import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/entities/user_profile_entity.dart';
import 'package:domain/repositories/user_profile_repository.dart';

class UserProfileUseCase {
  final UserProfileRepository _userProfileRepository;

  UserProfileUseCase(this._userProfileRepository);

  Future<UserProfileEntity?> getAuthenticatedUserProfile(AuthSessionEntity session) async {
    final user = await _userProfileRepository.getAuthenticatedUserProfile(session);
    return user;
  }

  Future<void> updateUserProfile({
    required int id,
    required String firstName,
    required String lastName,
    required String bio,
    required Uint8List imageData,
    required bool hasDeletedImage,
    required Function(EditUserProfileStatus) onUpdateProgress,
  }) async {
    await _userProfileRepository.updateUserProfile(
        id, firstName, lastName, bio, imageData, hasDeletedImage, onUpdateProgress);
  }

  Future<void> deleteProfilePicture(int id) async {
    await _userProfileRepository.deleteProfilePicture(id);
  }

  Future<Uint8List> fetchUserProfilePicture(int id) async {
    final imageData = await _userProfileRepository.fetchUserProfileImage(id);
    return imageData;
  }
}
