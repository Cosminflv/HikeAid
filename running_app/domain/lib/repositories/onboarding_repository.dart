import 'package:domain/entities/auth_session_entity.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:domain/entities/registration_status.dart';
import 'package:domain/entities/user_profile_entity.dart';

/// A repository interface for handling user authentication and onboarding operations.
///
/// This repository provides methods for user authentication, registration,
/// signing out, and checking for existing authentication sessions.
abstract class OnboardingRepository {
  /// Authenticates a user with the given [username] and [password].
  ///
  /// - Parameters:
  ///   - [username]: The username of the user attempting to log in.
  ///   - [password]: The password associated with the user account.
  ///   - [onAuthProgressUpdated]: A callback function that is triggered with updates
  ///     on the authentication progress. Receives an [AuthenticationStatus] indicating
  ///     the current stage or outcome of the authentication process.
  /// - Returns: A [Future<void>] that completes when the authentication process finishes.
  /// - Throws:
  ///   - [AuthenticationException] if authentication fails due to incorrect credentials
  ///     or other reasons.
  Future<void> authenticate({
    required String username,
    required String password,
    required Function(AuthenticationStatus) onAuthProgressUpdated,
  });

  /// Registers a new user with the provided information.
  ///
  /// - Parameters:
  ///   - [username]: The desired username for the new account.
  ///   - [password]: The desired password for the account.
  ///   - [firstName]: The first name of the user.
  ///   - [lastName]: The last name of the user.
  ///   - [city]: The city where the user resides.
  ///   - [country]: The country where the user resides.
  ///   - [weight]: The user's weight, represented as an integer (e.g., kilograms).
  ///   - [gender]: The user's gender, represented by an [EGenderEntity].
  ///   - [birthdate]: The user's date of birth as a [DateTime].
  ///   - [onRegistrationProgressUpdated]: A callback function invoked with updates on the
  ///     registration process. Receives a [RegistrationStatus] indicating the current
  ///     stage or outcome of the registration process.
  /// - Returns: A [Future<void>] that completes when the registration process finishes.
  /// - Throws:
  ///   - [RegistrationException] if registration fails due to validation errors,
  ///     duplicate usernames, or other reasons.
  Future<void> register({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    required String city,
    required String country,
    required int weight,
    required EGenderEntity gender,
    required DateTime birthdate,
    required Function(RegistrationStatus status) onRegistrationProgressUpdated,
  });

  /// Signs out the user associated with the specified [userId].
  ///
  /// - Parameters:
  ///   - [userId]: The ID of the user to sign out.
  /// - Returns: A [Future<bool>] that resolves to `true` if the user was successfully signed out,
  ///   or `false` otherwise.
  /// - Throws:
  ///   - [SignOutException] if the sign-out process fails.
  Future<bool> signOut(int userId);

  /// Checks if there is an active authentication session.
  ///
  /// - Returns: A [Future<AuthSessionEntity?>] that resolves to an [AuthSessionEntity]
  ///   if a session exists, or `null` if no session is active.
  /// - Note: Use this method to determine whether a user needs to reauthenticate
  ///   or if they are already signed in.
  Future<AuthSessionEntity?> checkForSession();
}
