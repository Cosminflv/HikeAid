import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:domain/entities/registration_status.dart';
import 'package:domain/repositories/onboarding_repository.dart';
import 'package:shared/domain/user_profile_entity.dart';

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
      String? city,
      String? country,
      int? weight,
      EGenderEntity? gender,
      DateTime? birthdate,
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
        city: city!,
        country: country!,
        weight: weight!,
        birthdate: birthdate!,
        gender: gender!,
        onRegistrationProgressUpdated: (status) => onProgress(status));
  }

  Future<AuthSessionEntity?> checkSignIn() async {
    final result = await _onboardingRepository.checkForSession();
    return result;
  }

  Future<bool?> logout(int userId) {
    throw UnimplementedError();
  }
}
