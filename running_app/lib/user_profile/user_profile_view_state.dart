import 'package:domain/entities/user_profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UserProfileViewState extends Equatable {}

class InitialProfileState extends UserProfileViewState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoadFailState extends UserProfileViewState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoadingState extends UserProfileViewState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoadedState extends UserProfileViewState {
  final UserProfileEntity profile;

  UserProfileLoadedState({required this.profile});

  @override
  List<Object?> get props => [profile];
}
