abstract class RegistrationStatus {}

enum RegistrationFailType { usernameExists, noConnection, other }

class InitialRegistrationStatus extends RegistrationStatus {}

class RegistrationLoadingStatus extends RegistrationStatus {}

class RegistrationSuccesfulStatus extends RegistrationStatus {}

class RegistrationFailedStatus extends RegistrationStatus {
  final RegistrationFailType reason;

  RegistrationFailedStatus({this.reason = RegistrationFailType.other});
}

class RegistrationCanceledStatus extends RegistrationStatus {}
