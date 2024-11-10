import 'package:domain/entities/user_profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ViewUserProfileViewState extends Equatable {}

class InitialProfileState extends ViewUserProfileViewState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoadFailState extends ViewUserProfileViewState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoadingState extends ViewUserProfileViewState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoadedState extends ViewUserProfileViewState {
  final UserProfileEntity profile;

  UserProfileLoadedState({required this.profile});

  @override
  List<Object?> get props => [profile];
}
