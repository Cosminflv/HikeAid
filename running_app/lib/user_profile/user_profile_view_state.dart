import 'package:shared/domain/tour_entity.dart';
import 'package:shared/domain/user_profile_entity.dart';
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
  final List<TourEntity> tours;

  UserProfileLoadedState({required this.profile, required this.tours});

  @override
  List<Object?> get props => [profile, tours];
}
