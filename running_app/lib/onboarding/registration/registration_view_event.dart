import 'package:domain/entities/registration_status.dart';
import 'package:shared/domain/user_profile_entity.dart';

abstract class RegistrationViewEvent {}

class PerformRegistrationEvent extends RegistrationViewEvent {
  final DateTime birthdate;

  PerformRegistrationEvent({required this.birthdate});
}

class RegistrationLoadingEvent extends RegistrationViewEvent {}

class RegistrationFailedEvent extends RegistrationViewEvent {
  final RegistrationFailType reason;

  RegistrationFailedEvent({required this.reason});
}

class RegistrationSuccesfulEvent extends RegistrationViewEvent {}

class ClearRegistrationEvent extends RegistrationViewEvent {}

class UpdateUsernameValueEvent extends RegistrationViewEvent {
  String value;

  UpdateUsernameValueEvent({required this.value});
}

class UpdateLastNameValueEvent extends RegistrationViewEvent {
  String value;

  UpdateLastNameValueEvent({required this.value});
}

class UpdateFirstNameValueEvent extends RegistrationViewEvent {
  String value;

  UpdateFirstNameValueEvent({required this.value});
}

class UpdatePasswordValueEvent extends RegistrationViewEvent {
  String value;

  UpdatePasswordValueEvent({required this.value});
}

class CompleteUserProfileEvent extends RegistrationViewEvent {
  final DateTime birthDate;
  final String city;
  final String country;
  final EGenderEntity gender;
  final int weight;

  CompleteUserProfileEvent(
      {required this.birthDate, required this.city, required this.country, required this.gender, required this.weight});
}
