import 'package:shared/domain/permission_repository.dart';
import 'package:domain/repositories/position_repository.dart';

import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared/domain/permissions.dart';
import 'package:shared/domain/position_entity.dart';

class LocationUseCase {
  final PermissionRepository _permissionRepository;
  final PositionRepository _positionRepository;
  final BehaviorSubject<bool> _locationPermissionStreamController = BehaviorSubject();

  Stream<PositionEntity?> get positionStream => _positionRepository.positionStream;
  Stream<bool> get locationStatusStream => _permissionRepository.locationStatusStream;
  Stream<bool> get locationPermissionStream => _locationPermissionStreamController.stream;

  PositionEntity? get position => _positionRepository.position;

  LocationUseCase(this._permissionRepository, this._positionRepository);

  initialize() {
    _permissionRepository.permissionStream(DPermissionType.locationWhenInUse).listen((event) async {
      if (event == DAccessStatus.granted) {
        await _positionRepository.setLivePosition();
      }

      _locationPermissionStreamController.add(event == DAccessStatus.granted);
    });
  }

  bool get hasPosition => position != null;

  bool get hasLocationPermission => _permissionRepository.isGranted(DPermissionType.locationWhenInUse);

  bool get isLocationEnabled => _permissionRepository.isLocationEnabled;

  Future<void> updatePermissionsStatus() async => await _permissionRepository.updatePermissionsStatus();

  Future<bool> askLocationPermission() async {
    bool hasGrantedPermission = _permissionRepository.isGranted(DPermissionType.locationWhenInUse);

    if (!hasGrantedPermission) {
      hasGrantedPermission = await _permissionRepository.askPermission(DPermissionType.locationWhenInUse);
    }
    return hasGrantedPermission;
  }

  Future<bool> openLocationService() async => await _permissionRepository.openLocationService();

  void cancelPositionListener() => _positionRepository.cancelPositionListener();
  void listenLivePosition() async => await _positionRepository.setLivePosition();
}
