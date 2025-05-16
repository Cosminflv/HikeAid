import 'package:built_collection/built_collection.dart';
import 'package:domain/repositories/position_prediction_repository.dart';
import 'package:gem_kit/core.dart';
import 'package:openapi/openapi.dart';
import 'package:shared/data/path_entity_impl.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:flutter/services.dart';

class PositionPredictionRepositoryImpl extends PositionPredictionRepository {
  final Openapi _openapi;

  PositionPredictionRepositoryImpl(this._openapi);

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

  @override
  Future<bool> confirmHike(PathEntity pathEntity) async {
    final path = pathEntity as PathEntityImpl;
    final coordinates = path.coordinates;

    final coordinatesDto = coordinates
        .skip(50)
        .toList()
        .asMap()
        .entries
        .where((entry) => entry.key % 2 == 0) // keep even-indexed elements after skipping 50
        .map((entry) => CoordinatesDto((b) {
              b.latitude = entry.value.latitude;
              b.longitude = entry.value.longitude;
            }));
    try {
      final result = await _openapi.getUserApi().apiUserConfirmHikePost(
            coordinatesDto: BuiltList<CoordinatesDto>(coordinatesDto),
          );
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
