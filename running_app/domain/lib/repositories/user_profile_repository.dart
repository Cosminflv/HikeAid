import 'package:domain/entities/edit_user_profile_status.dart';
import 'package:domain/entities/user_profile_entity.dart';

import 'dart:typed_data';

/// A repository interface for managing user profile data.
///
/// This repository defines the contract for retrieving, updating, and managing
/// user profiles. Implementations of this interface can connect to various
/// data sources such as a remote server, a local database, or in-memory storage.
abstract class UserProfileRepository {
  /// Retrieves the profile of the authenticated user by their [userId].
  ///
  /// - Parameters:
  ///   - [userId]: The unique identifier of the user whose profile is to be retrieved.
  /// - Returns: A [Future] that resolves to a [UserProfileEntity] representing
  ///   the user's profile, or `null` if the user profile could not be found.
  /// - Throws:
  ///   - [SomeSpecificException] if the retrieval fails due to connectivity issues.
  Future<UserProfileEntity?> getAuthenticatedUserProfile(int userId);

  /// Updates the user's profile with the provided details.
  ///
  /// - Parameters:
  ///   - [firstName]: The user's first name.
  ///   - [lastName]: The user's last name.
  ///   - [bio]: A short biography or description of the user.
  ///   - [city]: The city where the user resides.
  ///   - [country]: The country where the user resides.
  ///   - [age]: The user's age in years.
  ///   - [weight]: The user's weight in kilograms.
  ///   - [gender]: The user's gender, represented by an [EGenderEntity].
  ///   - [birthDate]: The user's birthdate as a [DateTime] object.
  ///   - [imageData]: A binary representation of the user's profile picture.
  ///   - [hasDeletedImage]: A flag indicating whether the user's profile picture
  ///     has been deleted.
  ///   - [onUpdateProgress]: A callback function that reports the progress of
  ///     the update operation. Accepts an [EditUserProfileStatus] as an argument.
  /// - Returns: A [Future] that completes when the update operation is successful.
  /// - Throws:
  ///   - [SomeSpecificException] if the update fails due to server or validation errors.
  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required String bio,
    required String city,
    required String country,
    required int age,
    required int weight,
    required EGenderEntity gender,
    required DateTime birthDate,
    required Uint8List imageData,
    required bool hasDeletedImage,
    required Function(EditUserProfileStatus) onUpdateProgress,
  });

  /// Deletes the user's current profile picture.
  ///
  /// - Returns: A [Future] that completes when the profile picture is successfully deleted.
  /// - Throws:
  ///   - [SomeSpecificException] if the deletion operation fails.
  Future<void> deleteProfilePicture();

  /// Fetches the default profile image for the given [id].
  ///
  /// - Returns: A [Future] that resolves to a [Uint8List] containing the binary
  ///   data of the default profile image.
  /// - Throws:
  ///   - [SomeSpecificException] if the operation fails due to connectivity or resource issues.
  Future<Uint8List> fetchDefaultUserProfileImage();
}
