import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationViewState extends Equatable {
  final String username;
  final String password;

  const AuthenticationViewState({this.username = '', this.password = ''});

  @override
  List<Object?> get props => [username, password];
}

class InitialAuthenticationState extends AuthenticationViewState {
  const InitialAuthenticationState({
    super.username,
    super.password,
  });

  InitialAuthenticationState copyWith({
    String? username,
    String? password,
  }) =>
      InitialAuthenticationState(username: username ?? this.username, password: password ?? this.password);

  @override
  List<Object?> get props => [
        username,
        password,
      ];
}

class AuthenticationLoadingState extends AuthenticationViewState {
  const AuthenticationLoadingState({
    super.username,
    super.password,
  });

  @override
  List<Object?> get props => [
        username,
        password,
      ];
}

class AuthenticationSuccesfulState extends AuthenticationViewState {
  final AuthSessionEntity session;

  const AuthenticationSuccesfulState({required this.session});

  @override
  List<Object?> get props => [
        username,
        password,
      ];
}

class AuthenticationFailedState extends AuthenticationViewState {
  final AuthenticationFailType reason;

  const AuthenticationFailedState({
    required this.reason,
    super.username,
    super.password,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        reason,
      ];
}
