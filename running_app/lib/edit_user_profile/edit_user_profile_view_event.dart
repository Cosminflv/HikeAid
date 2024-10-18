import 'dart:typed_data';

import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/entities/user_profile_entity.dart';

abstract class EditUserProfileViewEvent {}

enum UserDetailType { firstName, lastName, bio, country, city }

class UpdateUserDetailEvent extends EditUserProfileViewEvent {
  UserDetailType type;
  String value;

  UpdateUserDetailEvent({required this.type, required this.value});
}

class UpdateUserBirthDateEvent extends EditUserProfileViewEvent {
  DateTime newDateTime;

  UpdateUserBirthDateEvent({required this.newDateTime});
}

class UpdateUserGenderEvent extends EditUserProfileViewEvent {
  EGenderEntity newGender;

  UpdateUserGenderEvent({required this.newGender});
}

class UpdateUserWeightEvent extends EditUserProfileViewEvent {
  int newWeight;

  UpdateUserWeightEvent({required this.newWeight});
}

class UpdateProfilePictureEvent extends EditUserProfileViewEvent {
  Uint8List imageData;

  UpdateProfilePictureEvent({required this.imageData});
}

class DeleteProfilePictureEvent extends EditUserProfileViewEvent {}

class UserProfileSavingEvent extends EditUserProfileViewEvent {}

class UpdateProfileFailedEvent extends EditUserProfileViewEvent {
  EditUserFailType reason;

  UpdateProfileFailedEvent(this.reason);
}

class UpdateProfileSuccessEvent extends EditUserProfileViewEvent {}

class FetchDefaultProfilePictureEvent extends EditUserProfileViewEvent {}

class UserProfileSaveRequestedEvent extends EditUserProfileViewEvent {
  UserProfileSaveRequestedEvent();
}

class InitializeEditUserProfileEvent extends EditUserProfileViewEvent {
  final int id;
  final String firstName;
  final String lastName;
  final String bio;
  final String country;
  final String city;
  final int age;
  final int weight;
  final EGenderEntity gender;
  final DateTime birthDate;
  final Uint8List imageData;

  InitializeEditUserProfileEvent({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.city,
    required this.country,
    required this.age,
    required this.gender,
    required this.weight,
    required this.birthDate,
    required this.imageData,
  });
}
