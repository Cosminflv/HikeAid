import 'package:domain/entities/registration_status.dart';

abstract class RegistrationRepository {
  Future<void> register(
      {required String username,
      required String password,
      required String firstName,
      required String lastName,
      required Function(RegistrationStatus) onRegistrationProgressUpdated});
}
