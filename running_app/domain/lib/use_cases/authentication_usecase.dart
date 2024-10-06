import 'package:domain/entities/authentication_status.dart';
import 'package:domain/entities/registration_status.dart';
import 'package:domain/repositories/onboarding_repository.dart';

class OnboardingUseCase {
  final OnboardingRepository _onboardingRepository;

  OnboardingUseCase(this._onboardingRepository);

  Future<void> authenticate(
      {String? username, String? password, required Function(AuthenticationStatus) onProgress}) async {
    if (username == null || password == null) {
      onProgress(AuthenticationFailed(reason: AuthenticationFailType.invalidCredentials));
      return;
    }

    await _onboardingRepository.authenticate(
        username: username, password: password, onAuthProgressUpdated: (status) => onProgress(status));
  }

  Future<void> register(
      {String? username,
      String? password,
      String? firstName,
      String? lastName,
      required Function(RegistrationStatus) onProgress}) async {
    if (username == null || password == null || firstName == null || lastName == null) {
      onProgress(RegistrationFailed(reason: RegistrationFailType.invalidCredentials));
      return;
    }

    await _onboardingRepository.register(
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
        onRegistrationProgressUpdated: (status) => onProgress(status));
  }

  Future<AuthenticationFailed?> logout() {
    throw UnimplementedError();
  }
}
