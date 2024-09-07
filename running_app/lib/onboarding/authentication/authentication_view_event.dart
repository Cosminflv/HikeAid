import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authentication_status.dart';

abstract class AuthenticationViewEvent {}

class PerformAuthenticationEvent extends AuthenticationViewEvent {}

class AuthenticationLoadingEvent extends AuthenticationViewEvent {}

class AuthResetEvent extends AuthenticationViewEvent {}

class AuthClearEvent extends AuthenticationViewEvent {}

class AuthenticationSuccesfulEvent extends AuthenticationViewEvent {
  final AuthSessionEntity session;

  AuthenticationSuccesfulEvent({required this.session});
}

class AuthenticationFailedEvent extends AuthenticationViewEvent {
  final AuthenticationFailType reason;

  AuthenticationFailedEvent({
    required this.reason,
  });
}

class UpdateUsernameValueEvent extends AuthenticationViewEvent {
  String value;

  UpdateUsernameValueEvent({required this.value});
}

class UpdatePasswordValueEvent extends AuthenticationViewEvent {
  String value;

  UpdatePasswordValueEvent({required this.value});
}
