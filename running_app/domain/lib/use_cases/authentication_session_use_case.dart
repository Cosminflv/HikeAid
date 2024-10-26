import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:domain/repositories/onboarding_repository.dart';

class AuthenticationSessionUseCase {
  final OnboardingRepository _onboardingRepository;

  AuthenticationSessionUseCase(this._onboardingRepository);

  Future<AuthSessionEntity?> checkForSession() async {
    final result = await _onboardingRepository.checkForSession();
    return result;
  }

  Future<AuthenticationFailed?> signOut() async {
    return await _onboardingRepository.signOut();
  }
}
