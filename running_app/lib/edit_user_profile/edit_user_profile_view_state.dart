import 'dart:typed_data';

import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:equatable/equatable.dart';

abstract class EditUserProfileViewState extends Equatable {}

class UserProfileInitial extends EditUserProfileViewState {
  final int id;
  final String firstName;
  final String lastName;
  final String bio;
  final Uint8List imageData;

  UserProfileInitial({
    this.id = 0,
    this.firstName = '',
    this.lastName = '',
    this.bio = '',
    Uint8List? imageData,
  }) : imageData = imageData ?? Uint8List(0);
  @override
  List<Object?> get props => [firstName, lastName, bio, imageData];
}

class UserProfileEditing extends EditUserProfileViewState {
  final int id;
  final String firstName;
  final String lastName;
  final String bio;
  final Uint8List imageData;
  final bool hasDeletedImage;

  UserProfileEditing({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.imageData,
    required this.hasDeletedImage,
  });

  UserProfileEditing copyWith({
    String? firstName,
    String? lastName,
    String? bio,
    Uint8List? imageData,
    bool? hasDeletedImage,
  }) {
    return UserProfileEditing(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      imageData: imageData ?? this.imageData,
      hasDeletedImage: hasDeletedImage ?? this.hasDeletedImage,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, bio, imageData, hasDeletedImage];
}

class UserProfileSaving extends EditUserProfileViewState {
  UserProfileSaving();

  @override
  List<Object?> get props => [];
}

class UserProfileEditSuccess extends EditUserProfileViewState {
  UserProfileEditSuccess();

  @override
  List<Object?> get props => [];
}

class UserProfileEditFailed extends EditUserProfileViewState {
  final EditUserFailType reason;
  UserProfileEditFailed(this.reason);

  @override
  List<Object?> get props => [];
}
