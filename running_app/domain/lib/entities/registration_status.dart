abstract class RegistrationStatus {}

enum RegistrationFailType { usernameExists, noConnection, invalidCredentials, other }

class RegistrationStarted extends RegistrationStatus {}

class RegistrationInProgress extends RegistrationStatus {}

class RegistrationSuccesfulStatus extends RegistrationStatus {}

class RegistrationFailed extends RegistrationStatus {
  final RegistrationFailType reason;

  RegistrationFailed({this.reason = RegistrationFailType.other});
}

class RegistrationCanceledStatus extends RegistrationStatus {}

extension RegistrationFailTypeExtension on RegistrationFailType {
  String get description {
    switch (this) {
      case RegistrationFailType.usernameExists:
        return "Username already exists";
      case RegistrationFailType.noConnection:
        return "No internet connection";
      case RegistrationFailType.invalidCredentials:
        return "Invalid credentials";
      case RegistrationFailType.other:
        return "An unknown error occurred";
    }
  }
}
