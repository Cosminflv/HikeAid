/// Represents the access status of a specific permission.
///
/// The [DAccessStatus] enum defines various states of permission access.
enum DAccessStatus {
  /// The permission has been explicitly denied by the user.
  denied,

  /// The permission has been granted by the user.
  granted,

  /// The permission is permanently denied, and the user must manually enable it in settings.
  permanentlyDenied,

  /// The permission is restricted by system policies or other constraints.
  restricted,
}

/// Represents the type of permission being requested or checked.
///
/// The [DPermissionType] enum defines various types of permissions the application may require.
enum DPermissionType {
  /// Permission to access the device's location while the app is in use.
  locationWhenInUse,

  /// Permission to use the device's camera.
  camera,

  /// Permission to manage external storage on the device.
  manageExternalStorage,
}

/// A repository interface for managing application permissions and access statuses.
///
/// This repository provides methods to request, check, and update permission statuses
/// for various types of permissions. It also provides streams to monitor changes in
/// permission and location statuses.
abstract class PermissionRepository {
  /// Returns a stream that provides real-time updates on the access status
  /// of the specified [permissionType].
  ///
  /// - Parameters:
  ///   - [permissionType]: The type of permission to monitor, represented by [DPermissionType].
  /// - Returns: A [Stream] of [DAccessStatus] that emits updates whenever the
  ///   permission status changes.
  /// - Usage:
  ///   Subscribe to this stream to react to permission status changes dynamically.
  Stream<DAccessStatus> permissionStream(DPermissionType permissionType);

  /// A stream that emits updates about the location services' status.
  ///
  /// - Returns: A [Stream] of [bool] that emits `true` if location services are enabled
  ///   and `false` otherwise.
  Stream<bool> get locationStatusStream;

  /// Requests the specified [permissionType] from the user.
  ///
  /// - Parameters:
  ///   - [permissionType]: The type of permission to request, represented by [DPermissionType].
  /// - Returns: A [Future<bool>] that resolves to `true` if the permission is granted
  ///   and `false` otherwise.
  Future<bool> askPermission(DPermissionType permissionType);

  /// Opens the device's location services settings to allow the user to enable location.
  ///
  /// - Returns: A [Future<bool>] that resolves to `true` if location services are successfully enabled
  ///   and `false` otherwise.
  Future<bool> openLocationService();

  /// Updates the current permission statuses for all tracked permissions.
  ///
  /// - Returns: A [Future<void>] that completes when the update is finished.
  /// - Note: Call this method to ensure that the application has the latest permission statuses.
  Future<void> updatePermissionsStatus();

  /// Gets the access status for the specified [permissionType].
  ///
  /// - Parameters:
  ///   - [permissionType]: The type of permission, represented by [DPermissionType].
  /// - Returns: A [DAccessStatus] indicating the current status of the permission.
  DAccessStatus getAccessStatus(DPermissionType permissionType);

  /// Checks if the specified [permissionType] is granted.
  ///
  /// - Parameters:
  ///   - [permissionType]: The type of permission to check.
  /// - Returns: `true` if the permission is granted; otherwise, `false`.
  bool isGranted(DPermissionType permissionType);

  /// Checks if the specified [permissionType] is permanently denied.
  ///
  /// - Parameters:
  ///   - [permissionType]: The type of permission to check.
  /// - Returns: `true` if the permission is permanently denied; otherwise, `false`.
  bool isPermanentlyDenied(DPermissionType permissionType);

  /// Checks if the specified [permissionType] is denied.
  ///
  /// - Parameters:
  ///   - [permissionType]: The type of permission to check.
  /// - Returns: `true` if the permission is denied; otherwise, `false`.
  bool isDenied(DPermissionType permissionType);

  /// Checks if the specified [permissionType] is restricted.
  ///
  /// - Parameters:
  ///   - [permissionType]: The type of permission to check.
  /// - Returns: `true` if the permission is restricted; otherwise, `false`.
  bool isRestricted(DPermissionType permissionType);

  /// Checks if location services are currently enabled on the device.
  ///
  /// - Returns: `true` if location services are enabled; otherwise, `false`.
  bool get isLocationEnabled;

  /// Cleans up any resources or listeners associated with this repository.
  ///
  /// - Returns: A [Future<void>] that completes when the cleanup process is finished.
  Future<void> dispose();
}
