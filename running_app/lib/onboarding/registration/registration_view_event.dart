import 'package:domain/entities/registration_status.dart';

abstract class RegistrationViewEvent {}

class PerformRegistrationEvent extends RegistrationViewEvent {}

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
