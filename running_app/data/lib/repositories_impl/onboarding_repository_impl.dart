import 'dart:convert';

import 'package:data/models/auth_session_entity_impl.dart';
import 'package:data/models/user_entity_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:domain/entities/registration_status.dart';
import 'package:domain/repositories/onboarding_repository.dart';
import 'package:openapi/openapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final Openapi _openapi;
  final FlutterSecureStorage _storage;

  OnboardingRepositoryImpl(this._openapi, this._storage);

  @override
  Future<void> authenticate(
      {required String username,
      required String password,
      required Function(AuthenticationStatus status) onAuthProgressUpdated}) async {
    try {
      onAuthProgressUpdated(AuthenticationStarted());
      onAuthProgressUpdated(AuthenticationInProgress());

      final result = await _openapi.getLoginApi().apiLoginLoginPost(
        loginDto: LoginDto(
          (builder) {
            builder.username = username;
            builder.password = password;
          },
        ),
      );
      if (result.statusCode == 200) {
        final data = result.data as Map<String, dynamic>;
        final jwtToken = data["token"];
        final userData = data["user"];
        _openapi.setBearerAuth("Bearer", jwtToken);
        await _storage.write(key: 'jwt', value: data['token']);
        await _storage.write(key: 'userId', value: userData['id'].toString());

        onAuthProgressUpdated(AuthenticationSuccesful(
            AuthSessionEntityImpl(accessToken: jwtToken, user: UserEntityImpl(id: userData["id"]))));
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

      final result = await _openapi.getUserApi().apiUserPost(
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
  Future<AuthenticationFailed?> signOut() async {
    await _storage.delete(key: "jwt");
    await _storage.delete(key: "userId");
    return null;
  }

  @override
  Future<AuthSessionEntity?> checkForSession() async {
    final token = await _storage.read(key: "jwt");
    final userId = await _storage.read(key: "userId");

    if (token == null || userId == null) return null;

    if (!await _isTokenValid(token)) return null;

    _openapi.setBearerAuth("Bearer", token);

    return AuthSessionEntityImpl(user: UserEntityImpl(id: int.parse(userId)), accessToken: token);
  }

  // Function to validate token expiration (optional)
  Future<bool> _isTokenValid(String token) async {
    // Decode the token and check the expiration time
    final List<String> parts = token.split('.');
    if (parts.length != 3) return false; // Not a valid JWT

    // Decode payload
    final String payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final Map<String, dynamic> payloadMap = jsonDecode(payload);

    final int exp = payloadMap['exp'];
    final DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return DateTime.now().isBefore(expirationDate);
  }
}
