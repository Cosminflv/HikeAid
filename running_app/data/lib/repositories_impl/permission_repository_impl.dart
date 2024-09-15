import 'package:domain/repositories/permission_repository.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:rxdart/rxdart.dart';

class PermissionRepositoryImpl extends PermissionRepository {
  final Map<DPermissionType, DAccessStatus> _permissionTypeToStatus = {
    DPermissionType.locationWhenInUse: DAccessStatus.denied,
    DPermissionType.manageExternalStorage: DAccessStatus.denied,
  };

  final Map<DPermissionType, BehaviorSubject<DAccessStatus>> _permissionStatusControllers = {
    for (var permissionType in DPermissionType.values)
      permissionType: BehaviorSubject<DAccessStatus>.seeded(
        DAccessStatus.denied,
      ),
  };

  final BehaviorSubject<bool> _locationStatusStreamController = BehaviorSubject();
  late bool _isLocationEnabled;

  PermissionRepositoryImpl() {
    gl.Geolocator.isLocationServiceEnabled().then((value) {
      _isLocationEnabled = value;
      _locationStatusStreamController.sink.add(_isLocationEnabled);
    });

    gl.Geolocator.getServiceStatusStream().listen((status) {
      switch (status) {
        case gl.ServiceStatus.enabled:
          _isLocationEnabled = true;
          break;
        case gl.ServiceStatus.disabled:
          _isLocationEnabled = false;
          break;
      }
      _locationStatusStreamController.sink.add(_isLocationEnabled);
    });

    _updateAccessStatus(DPermissionType.locationWhenInUse);
  }

  @override
  Stream<DAccessStatus> permissionStream(DPermissionType permissionType) =>
      _permissionStatusControllers[permissionType]!.stream;

  @override
  Future<bool> askPermission(DPermissionType permissionType) async {
    final locationPermissionStatus = getAccessStatus(permissionType);

    if (locationPermissionStatus == DAccessStatus.permanentlyDenied) {
      await openAppSettings();
      final status = getAccessStatus(permissionType);
      return status == DAccessStatus.granted;
    }

    var currentStatus = locationPermissionStatus;

    if (currentStatus != DAccessStatus.granted) {
      await _request(permissionType);
      currentStatus = getAccessStatus(permissionType);
    }

    return currentStatus == DAccessStatus.granted;
  }

  @override
  DAccessStatus getAccessStatus(DPermissionType permissionType) => _permissionTypeToStatus[permissionType]!;

  @override
  bool isGranted(DPermissionType permissionType) => getAccessStatus(permissionType) == DAccessStatus.granted;

  @override
  bool isPermanentlyDenied(DPermissionType permissionType) =>
      getAccessStatus(permissionType) == DAccessStatus.permanentlyDenied;

  @override
  bool isDenied(DPermissionType permissionType) => getAccessStatus(permissionType) == DAccessStatus.denied;

  @override
  bool isRestricted(DPermissionType permissionType) => getAccessStatus(permissionType) == DAccessStatus.restricted;

  @override
  Future<void> dispose() async {
    for (var controller in _permissionStatusControllers.values) {
      await controller.close();
    }
  }

  Future<DAccessStatus> _request(DPermissionType permissionType) async {
    final permission = _toPermission(permissionType);

    if (permission == null) {
      return DAccessStatus.denied;
    }

    final permissionGranted = await permission.isGranted;

    if (!permissionGranted) {
      await permission.request();
    }

    await _updateAccessStatus(permissionType);

    return getAccessStatus(permissionType);
  }

  Future<void> _updateAccessStatus(DPermissionType permissionType) async {
    final permission = _toPermission(permissionType);

    if (permission == null) return;

    final oldStatus = getAccessStatus(permissionType);
    final permissionStatus = await permission.status;

    final newStatus = _toAccessStatus(permissionStatus);

    if (newStatus != null && newStatus != oldStatus) {
      _permissionTypeToStatus[permissionType] = newStatus;

      _permissionStatusControllers[permissionType]!.add(newStatus);
    }
  }

  Permission? _toPermission(DPermissionType permissionType) {
    switch (permissionType) {
      case DPermissionType.locationWhenInUse:
        return Permission.locationWhenInUse;
      case DPermissionType.camera:
        return Permission.camera;
      default:
        return null;
    }
  }

  DAccessStatus? _toAccessStatus(PermissionStatus permissionStatus) {
    switch (permissionStatus) {
      case PermissionStatus.granted:
        return DAccessStatus.granted;
      case PermissionStatus.restricted:
        return DAccessStatus.restricted;
      case PermissionStatus.permanentlyDenied:
        return DAccessStatus.permanentlyDenied;
      case PermissionStatus.denied:
        return DAccessStatus.denied;
      default:
        return null;
    }
  }

  @override
  bool get isLocationEnabled => _isLocationEnabled;

  @override
  Stream<bool> get locationStatusStream => _locationStatusStreamController.stream;

  @override
  Future<void> updatePermissionsStatus() async => await _updateAccessStatus(DPermissionType.locationWhenInUse);

  @override
  Future<bool> openLocationService() async {
    return await gl.Geolocator.openLocationSettings();
  }
}
