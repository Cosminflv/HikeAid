import 'package:domain/entities/auth_session_entity.dart';

enum AuthrnticationFailType { invalidCredentials, noConnection, other }

abstract class AuthenticationStatus {}

class AuthenticationStarted extends AuthenticationStatus {}

class AuthenticationInProgress extends AuthenticationStatus {}

class AuthenticationSuccesful extends AuthenticationStatus {
  final AuthSessionEntity session;

  AuthenticationSuccesful(this.session);
}

class AuthenticationFailed extends AuthenticationStatus {
  final AuthrnticationFailType reason;

  AuthenticationFailed({required this.reason});
}
