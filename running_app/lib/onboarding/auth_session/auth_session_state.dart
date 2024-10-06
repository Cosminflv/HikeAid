

import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:equatable/equatable.dart';


abstract class AuthSessionState extends Equatable {}

class AuthSessionExistingState extends AuthSessionState {
  final AuthSessionEntity session;
  AuthSessionExistingState(this.session);

  @override
  List<Object?> get props => [session];
}

class AuthSessionNotExistingState extends AuthSessionState {
  @override
  List<Object?> get props => [];
}

class AuthSessionFailureState extends AuthSessionState {
  final AuthenticationFailed reason;

  AuthSessionFailureState(this.reason);

  @override
  List<Object?> get props => [reason];
}
