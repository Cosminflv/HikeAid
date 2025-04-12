import 'package:shared/domain/user_profile_entity.dart';

class UserProfileEntityImpl extends UserProfileEntity {
  UserProfileEntityImpl(
      {required super.id,
      required super.username,
      required super.firstName,
      required super.lastName,
      required super.bio,
      required super.age,
      required super.birthDate,
      required super.city,
      required super.country,
      required super.gender,
      required super.weight,
      required super.imageData,
      required super.friendsCount});
}
