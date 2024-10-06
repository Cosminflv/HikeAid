import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class UserProfileEntity extends Equatable {
  final int id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final Uint8List? profilePicture;

  UserProfileEntity({required this.id, this.username, this.firstName, this.lastName, this.bio, this.profilePicture});

  @override
  List<Object?> get props => [id, username, firstName, lastName, bio, profilePicture];  
}
