import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class UserProfileEntity extends Equatable {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String bio;
  final Uint8List imageData;
  final int friendsCount;

  UserProfileEntity(
      {required this.id,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.bio,
      required this.imageData,
      required this.friendsCount});

  @override
  List<Object?> get props => [id, username, firstName, lastName, bio, imageData, friendsCount];
}
