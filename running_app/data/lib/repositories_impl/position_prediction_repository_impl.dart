import 'package:domain/repositories/position_prediction_repository.dart';
import 'package:gem_kit/core.dart';
import 'package:shared/data/path_entity_impl.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:flutter/services.dart';

class PositionPredictionRepositoryImpl extends PositionPredictionRepository {
  @override
  Future<PathEntity> importGPXDemo(String assetsPath) async {
    final fileBytes = await rootBundle.load('assets/gpx_files/gpx_file1.gpx');
    final buffer = fileBytes.buffer;
    final pathData = buffer.asUint8List(
      fileBytes.offsetInBytes,
      fileBytes.lengthInBytes,
    );

    final PathEntityImpl pathEntity = PathEntityImpl(
      ref: Path.create(data: pathData, format: PathFileFormat.gpx),
    );

    return pathEntity;
  }
}
