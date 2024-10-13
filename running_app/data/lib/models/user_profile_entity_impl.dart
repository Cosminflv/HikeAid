import 'package:domain/entities/user_profile_entity.dart';

class UserProfileEntityImpl extends UserProfileEntity {
  UserProfileEntityImpl(
      {required super.id,
      required super.username,
      required super.firstName,
      required super.lastName,
      required super.bio,
      required super.imageData,
      required super.friendsCount});
}
