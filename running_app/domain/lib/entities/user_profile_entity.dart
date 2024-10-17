import 'dart:typed_data';

import 'package:equatable/equatable.dart';

enum EGenderEntity { man, woman }

abstract class UserProfileEntity extends Equatable {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String bio;
  final String country;
  final String city;
  final EGenderEntity gender;
  final DateTime birthDate;
  final Uint8List imageData;
  final int age;
  final int friendsCount;
  final int weight;

  UserProfileEntity(
      {required this.id,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.bio,
      required this.imageData,
      required this.gender,
      required this.birthDate,
      required this.age,
      required this.weight,
      required this.country,
      required this.city,
      required this.friendsCount});

  @override
  List<Object?> get props => [
        id,
        username,
        firstName,
        lastName,
        bio,
        imageData,
        friendsCount,
        gender,
        age,
        country,
        city,
        weight,
        birthDate,
      ];
}
