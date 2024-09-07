import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authrntication_status.dart';

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

class UpdateLoginUsernameValueEvent extends AuthenticationViewEvent {
  String value;

  UpdateLoginUsernameValueEvent({required this.value});
}

class UpdateLoginPasswordValueEvent extends AuthenticationViewEvent {
  String value;

  UpdateLoginPasswordValueEvent({required this.value});
}
