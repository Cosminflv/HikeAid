import 'dart:typed_data';

import 'package:shared/domain/tour_entity.dart';

abstract class RecorderRepository {
  Future<void> startRecording();

  Future<String> stopRecording();

  Future<String> exportGMToGPX(Uint8List binaryGM, String gmFileName);

  String importGPXFromPath(String gpxPath);
  Future<String> importGPXFromBinary(Uint8List binaryData);
}

class PickGPXResult {
  final TourEntity tour;
  final String gpxPath;

  PickGPXResult({required this.tour, required this.gpxPath});
}
