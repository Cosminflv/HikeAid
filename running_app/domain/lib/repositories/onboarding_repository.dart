import 'package:domain/entities/authentication_status.dart';
import 'package:domain/entities/registration_status.dart';

abstract class OnboardingRepository {
  Future<void> authenticate(
      {required String username,
      required String password,
      required Function(AuthenticationStatus) onAuthProgressUpdated});

  Future<void> register(
      {required String username,
      required String password,
      required String firstName,
      required String lastName,
      required Function(RegistrationStatus status) onRegistrationProgressUpdated});

  Future<AuthenticationFailed?> signOut();
}
