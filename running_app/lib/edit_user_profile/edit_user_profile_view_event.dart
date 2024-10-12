import 'dart:typed_data';

import 'package:domain/entities/edit_user_profile_status.dart';

abstract class EditUserProfileViewEvent {}

enum UserDetailType { firstName, lastName, bio, profilePicture }

class UpdateUserDetailEvent extends EditUserProfileViewEvent {
  UserDetailType type;
  Uint8List? imageData;
  String value;

  UpdateUserDetailEvent({required this.type, required this.value, this.imageData});
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

class FetchProfilePictureEvent extends EditUserProfileViewEvent {}

class UserProfileSaveRequestedEvent extends EditUserProfileViewEvent {
  UserProfileSaveRequestedEvent();
}

class InitializeEditUserProfileEvent extends EditUserProfileViewEvent {
  final int id;
  final String firstName;
  final String lastName;
  final String bio;
  final Uint8List imageData;

  InitializeEditUserProfileEvent({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.imageData,
  });
}
