import 'package:domain/entities/authrntication_status.dart';
import 'package:domain/repositories/authentication_repository.dart';
import 'package:openapi/openapi.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final UserApi _userApi;

  AuthenticationRepositoryImpl(this._userApi);

  @override
  Future<void> authenticate(
      {required String username,
      required String password,
      required Function(AuthenticationStatus status) onAuthProgressUpdated}) async {
    try {
      onAuthProgressUpdated(AuthenticationStarted());
      onAuthProgressUpdated(AuthenticationInProgress());

      final result = await _userApi.apiUserLoginPost(
        loginDto: LoginDto(
          (builder) {
            builder.username = username;
            builder.password = password;
          },
        ),
      );
      if (result.statusCode == 200) {
        print("Login successful");
      }
    } catch (e) {
      print("$e");
    }
  }

  @override
  Future<AuthenticationFailed?> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
