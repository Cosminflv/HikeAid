import 'package:domain/entities/registration_status.dart';
import 'package:domain/entities/user_profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RegistrationViewState extends Equatable {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String city;
  final String country;
  final int weight;
  final EGenderEntity gender;
  final bool hasCompletedProfile;

  const RegistrationViewState({
    this.username = '',
    this.password = '',
    this.firstName = '',
    this.lastName = '',
    this.city = '',
    this.country = '',
    this.weight = 0,
    this.gender = EGenderEntity.man,
    this.hasCompletedProfile = false,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        firstName,
        lastName,
        city,
        country,
        weight,
        gender,
        hasCompletedProfile,
      ];
}

class InitialRegistrationState extends RegistrationViewState {
  const InitialRegistrationState(
      {super.username,
      super.password,
      super.firstName,
      super.lastName,
      super.city,
      super.country,
      super.weight,
      super.gender,
      super.hasCompletedProfile});

  InitialRegistrationState copyWith(
          {String? username,
          String? password,
          String? firstName,
          String? lastName,
          String? city,
          String? country,
          EGenderEntity? gender,
          int? weight,
          bool? hasCompletedProfile}) =>
      InitialRegistrationState(
        username: username ?? this.username,
        password: password ?? this.password,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        city: city ?? this.city,
        country: country ?? this.country,
        gender: gender ?? this.gender,
        weight: weight ?? this.weight,
        hasCompletedProfile: hasCompletedProfile ?? this.hasCompletedProfile,
      );

  @override
  List<Object?> get props => [
        username,
        password,
        firstName,
        lastName,
        city,
        country,
        gender,
        weight,
        hasCompletedProfile,
      ];
}

class RegistrationLoadingState extends RegistrationViewState {
  const RegistrationLoadingState(
      {super.username,
      super.password,
      super.firstName,
      super.lastName,
      super.city,
      super.country,
      super.weight,
      super.gender,
      super.hasCompletedProfile});

  @override
  List<Object?> get props => [
        username,
        password,
        firstName,
        lastName,
        city,
        country,
        gender,
        weight,
        hasCompletedProfile,
      ];
}

class RegistrationFailedState extends RegistrationViewState {
  final RegistrationFailType reason;

  const RegistrationFailedState(
      {super.username,
      super.password,
      super.firstName,
      super.lastName,
      super.city,
      super.country,
      super.weight,
      super.gender,
      super.hasCompletedProfile,
      required this.reason});
}

class RegistrationSuccesfulState extends RegistrationViewState {
  const RegistrationSuccesfulState({
    super.username,
    super.password,
    super.firstName,
    super.lastName,
    super.city,
    super.country,
    super.weight,
    super.gender,
    super.hasCompletedProfile,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        firstName,
        lastName,
        city,
        country,
        gender,
        weight,
        hasCompletedProfile,
      ];
}
