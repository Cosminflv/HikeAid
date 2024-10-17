import 'dart:typed_data';

import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/entities/user_profile_entity.dart';
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
  final String city;
  final String country;
  final int age;
  final int weight;
  final EGenderEntity gender;
  final DateTime birthDate;
  final bool hasDeletedImage;

  UserProfileEditing({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.city,
    required this.country,
    required this.age,
    required this.weight,
    required this.gender,
    required this.imageData,
    required this.birthDate,
    required this.hasDeletedImage,
  });

  UserProfileEditing copyWith({
    String? firstName,
    String? lastName,
    String? bio,
    String? country,
    String? city,
    int? age,
    int? weight,
    EGenderEntity? gender,
    DateTime? birthDate,
    Uint8List? imageData,
    bool? hasDeletedImage,
  }) {
    return UserProfileEditing(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      city: city ?? this.city,
      country: country ?? this.country,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      imageData: imageData ?? this.imageData,
      birthDate: birthDate ?? this.birthDate,
      hasDeletedImage: hasDeletedImage ?? this.hasDeletedImage,
    );
  }

  @override
  List<Object?> get props =>
      [firstName, lastName, bio, imageData, hasDeletedImage, country, age, weight, city, gender, birthDate];
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
  List<Object?> get props => [reason];
}
