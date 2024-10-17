import 'dart:typed_data';

import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/entities/user_profile_entity.dart';

abstract class UserProfileRepository {
  Future<UserProfileEntity?> getAuthenticatedUserProfile(AuthSessionEntity session);
  Future<void> updateUserProfile(int id, String firstName, String lastName, String bio, Uint8List imageData,
      bool hasDeletedImage, Function(EditUserProfileStatus) onUpdateProgress);
  Future<void> deleteProfilePicture(int id);
  Future<Uint8List> fetchDefaultUserProfileImage(int id);
}
