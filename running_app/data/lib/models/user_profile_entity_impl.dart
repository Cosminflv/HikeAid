import 'package:domain/entities/user_profile_entity.dart';

class UserProfileEntityImpl extends UserProfileEntity {
  UserProfileEntityImpl(
      {required super.id,
      super.username,
      super.firstName,
      super.lastName,
      super.bio,
      super.imageData,
      super.friendsCount});
}
