import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:domain/entities/registration_status.dart';
import 'package:domain/entities/user_profile_entity.dart';

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
      required String city,
      required String country,
      required int weight,
      required EGenderEntity gender,
      required DateTime birthdate,
      required Function(RegistrationStatus status) onRegistrationProgressUpdated});

  Future<bool> signOut(int userId);

  Future<AuthSessionEntity?> checkForSession();
}
