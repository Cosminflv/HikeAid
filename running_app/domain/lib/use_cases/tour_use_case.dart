import 'package:domain/entities/tour_entity.dart';
import 'package:domain/repositories/permission_repository.dart';

import 'dart:typed_data';

import 'package:domain/repositories/tour_repository.dart';

class TourUseCase {
  final TourRepository _tourRepository;
  final PermissionRepository _permissionRepository;

  TourUseCase(this._tourRepository, this._permissionRepository);

  Future<void> startRecording() async {
    final granted = await _permissionRepository.askPermission(DPermissionType.manageExternalStorage);

    // if (!granted) return;

    _tourRepository.startRecording();
  }

  Future<TourEntity?> stopRecording({Uint8List? preview}) async => _tourRepository.stopRecording(preview: preview);

  Future<List<TourEntity>> getGPXFiles() => _tourRepository.getRecordedTours();
}
