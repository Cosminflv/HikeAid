enum DAccessStatus { denied, granted, permanentlyDenied, restricted }

enum DPermissionType { locationWhenInUse, camera, manageExternalStorage }

abstract class PermissionRepository {
  // Streams
  Stream<DAccessStatus> permissionStream(DPermissionType permissionType);
  Stream<bool> get locationStatusStream;

  // Requesting Permissions
  Future<bool> askPermission(DPermissionType permissionType);
  Future<bool> openLocationService();
  Future<void> updatePermissionsStatus();

  // Access Status
  DAccessStatus getAccessStatus(DPermissionType permissionType);

  // Check Permissions
  bool isGranted(DPermissionType permissionType);
  bool isPermanentlyDenied(DPermissionType permissionType);
  bool isDenied(DPermissionType permissionType);
  bool isRestricted(DPermissionType permissionType);

  bool get isLocationEnabled;

  // Cleanup
  Future<void> dispose();
}
