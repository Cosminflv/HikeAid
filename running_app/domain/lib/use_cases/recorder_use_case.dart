import 'dart:typed_data';

import 'package:shared/domain/permission_repository.dart';
import 'package:domain/repositories/recorder_repository.dart';
import 'package:shared/domain/permissions.dart';

class RecorderUseCase {
  final RecorderRepository _tourRepository;
  final PermissionRepository _permissionRepository;

  RecorderUseCase(this._tourRepository, this._permissionRepository);

  Future<void> startRecording() async {
    await _permissionRepository.askPermission(DPermissionType.manageExternalStorage);

    _tourRepository.startRecording();
  }

  Future<String> stopRecording() async => _tourRepository.stopRecording();

  String importGPXFromPath(String gpxPath) => _tourRepository.importGPXFromPath(gpxPath);
  Future<String> importGPXFromBinary(Uint8List binaryData) => _tourRepository.importGPXFromBinary(binaryData);
}
