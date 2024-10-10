import 'package:data/models/auth_session_entity_impl.dart';
import 'package:data/models/user_entity_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:domain/entities/registration_status.dart';
import 'package:domain/repositories/onboarding_repository.dart';
import 'package:openapi/openapi.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final UserApi _userApi;

  OnboardingRepositoryImpl(this._userApi);

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
        final data = result.data as Map<String, dynamic>;
        onAuthProgressUpdated(AuthenticationSuccesful(
            AuthSessionEntityImpl(user: UserEntityImpl(id: data['id']!, username: data['username']!))));
        return;
      }

      if (result.statusCode == 400) {
        onAuthProgressUpdated(AuthenticationFailed(reason: AuthenticationFailType.invalidCredentials));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        // Handle connection timeout and return an appropriate authentication failure status
        onAuthProgressUpdated(AuthenticationFailed(reason: AuthenticationFailType.timeout));
      } else {
        // Handle other Dio errors (such as network issues)
        onAuthProgressUpdated(AuthenticationFailed(reason: AuthenticationFailType.other));
      }
    }
  }

  @override
  Future<void> register(
      {required String username,
      required String password,
      required String firstName,
      required String lastName,
      required Function(RegistrationStatus status) onRegistrationProgressUpdated}) async {
    try {
      onRegistrationProgressUpdated(RegistrationStarted());
      onRegistrationProgressUpdated(RegistrationInProgress());

      final result = await _userApi.apiUserPost(
        userDto: UserDto(
          (builder) {
            builder.username = username;
            builder.passwordHash = password;
            builder.firstName = firstName;
            builder.lastName = lastName;
          },
        ),
      );

      if (result.statusCode == 201) onRegistrationProgressUpdated(RegistrationSuccesfulStatus());
      if (result.statusCode == 400) {
        onRegistrationProgressUpdated(RegistrationFailed(reason: RegistrationFailType.usernameExists));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<AuthenticationFailed?> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
