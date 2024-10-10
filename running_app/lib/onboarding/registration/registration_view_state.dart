import 'package:domain/entities/registration_status.dart';
import 'package:equatable/equatable.dart';

abstract class RegistrationViewState extends Equatable {
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  const RegistrationViewState({this.username = '', this.password = '', this.firstName = '', this.lastName = ''});

  @override
  List<Object?> get props => [username, password];
}

class InitialRegistrationState extends RegistrationViewState {
  const InitialRegistrationState({super.username, super.password, super.firstName, super.lastName});

  InitialRegistrationState copyWith({
    String? username,
    String? password,
    String? firstName,
    String? lastName,
  }) =>
      InitialRegistrationState(
        username: username ?? this.username,
        password: password ?? this.password,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  @override
  List<Object?> get props => [
        username,
        password,
        firstName,
        lastName,
      ];
}

class RegistrationLoadingState extends RegistrationViewState {
  const RegistrationLoadingState({super.username, super.password, super.firstName, super.lastName});

  @override
  List<Object?> get props => [
        username,
        password,
        firstName,
        lastName,
      ];
}

class RegistrationFailedState extends RegistrationViewState {
  final RegistrationFailType reason;

  const RegistrationFailedState(
      {super.username, super.password, super.firstName, super.lastName, required this.reason});
}

class RegistrationSuccesfulState extends RegistrationViewState {
  const RegistrationSuccesfulState({
    super.username,
    super.password,
    super.firstName,
    super.lastName,
  });

  @override
  List<Object?> get props => [
        username,
        password,
        firstName,
        lastName,
      ];
}
