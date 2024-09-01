import 'package:domain/entities/authrntication_status.dart';
import 'package:domain/repositories/authentication_repository.dart';

class AuthenticationUseCase {
  final AuthenticationRepository _authRepository;

  AuthenticationUseCase(this._authRepository);

  Future<void> authenticate(
      {String? username, String? password, required Function(AuthenticationStatus) onProgress}) async {
    if (username == null || password == null) {
      onProgress(AuthenticationFailed(reason: AuthenticationFailType.invalidCredentials));
      return;
    }

    _authRepository.authenticate(
        username: username, password: password, onAuthProgressUpdated: (status) => onProgress(status));
  }
}
