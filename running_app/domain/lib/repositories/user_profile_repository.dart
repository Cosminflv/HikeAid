import 'dart:typed_data';

import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/entities/user_profile_entity.dart';

abstract class UserProfileRepository {
  Future<UserProfileEntity?> getAuthenticatedUserProfile(AuthSessionEntity session);
  Future<void> updateUserProfile(
      {required int id,
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
      required Function(EditUserProfileStatus) onUpdateProgress});
  Future<void> deleteProfilePicture(int id);
  Future<Uint8List> fetchDefaultUserProfileImage(int id);
}
