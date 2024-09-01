import 'package:domain/entities/authrntication_status.dart';

abstract class AuthenticationRepository {
  Future<void> authenticate(
      {required String username,
      required String password,
      required Function(AuthenticationStatus) onAuthProgressUpdated});

  Future<AuthenticationFailed?> signOut();
}
