import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationViewState extends Equatable {
  final String username;
  final String password;
  final bool isLoggedIn;

  const AuthenticationViewState({this.username = '', this.password = '', this.isLoggedIn = false});

  @override
  List<Object?> get props => [username, password, isLoggedIn];
}

class InitialAuthenticationState extends AuthenticationViewState {
  const InitialAuthenticationState({
    super.username,
    super.password,
    super.isLoggedIn,
  });

  InitialAuthenticationState copyWith({
    String? username,
    String? password,
    bool? isLoggedIn,
  }) =>
      InitialAuthenticationState(
          username: username ?? this.username,
          password: password ?? this.password,
          isLoggedIn: isLoggedIn ?? this.isLoggedIn);

  @override
  List<Object?> get props => [username, password, isLoggedIn];
}

class AuthenticationLoadingState extends AuthenticationViewState {
  const AuthenticationLoadingState({
    super.username,
    super.password,
    super.isLoggedIn,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        isLoggedIn,
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
