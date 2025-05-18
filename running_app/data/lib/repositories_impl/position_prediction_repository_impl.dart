import 'package:built_collection/built_collection.dart';
import 'package:data/factories/path_factory_impl.dart';
import 'package:data/utils/web_socket_service.dart';
import 'package:domain/factories/path_factory.dart';
import 'package:domain/repositories/position_prediction_repository.dart';
import 'package:gem_kit/core.dart';
import 'package:openapi/openapi.dart';
import 'package:shared/data/coordinates_entity_impl.dart';
import 'package:shared/data/path_entity_impl.dart';
import 'package:shared/domain/hike_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:shared/data/hike_entity_impl.dart';
import 'package:flutter/services.dart';
import 'package:shared/domain/tour_entity.dart';

class PositionPredictionRepositoryImpl extends PositionPredictionRepository {
  final Openapi _openapi;
  late WebSocketService _webSocketService;
  late PathFactory _pathFactory;

  PositionPredictionRepositoryImpl(this._openapi) {
    _pathFactory = PathFactoryImpl();
  }

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

  @override
  Future<void> registerPositionTransfer(int userId) async {
    _webSocketService = WebSocketService(userId: userId);

    _webSocketService.connect();
  }

  @override
  void unregisterPositionTransfer() {
    _webSocketService.dispose();
  }

  @override
  void sendCoordinates(CoordinatesWithTimestamp coordinates) {
    _webSocketService.sendCoordinate(
      CoordinatePredictionDto(
        latitude: coordinates.latLng.latitude,
        longitude: coordinates.latLng.longitude,
        elevation: coordinates.altitude.toDouble(),
        time: coordinates.timestamp,
      ),
    );
  }

  @override
  Future<HikeEntity?> getCurrentHike(int userId) async {
    try {
      final result = await _openapi.getUserApi().apiUserUserIdGetUserConfirmedHikeGet(userId: userId);
      if (result.statusCode == 200) {
        final data = result.data as Map<String, dynamic>;

        //final trkCoordsMapList = data['trackCoordinates'] as List<Map<String, List<Map<String, double>>>>;
        //final progressCoordsMapList = data['userProgressCoordinates'] as List<Map<String, double>>;

        final trkCoords = (data['trackCoordinates'] as List<dynamic>).map((e) => e as Map<String, dynamic>).map((map) {
          // cast to num first to handle both int and double, then toDouble()
          final lat = (map['latitude'] as num).toDouble();
          final lon = (map['longitude'] as num).toDouble();
          return CoordinatesEntityImpl(latitude: lat, longitude: lon);
        }).toList();

// 2) User progress coordinates
        final progressCoords =
            (data['userProgressCoordinates'] as List<dynamic>).map((e) => e as Map<String, dynamic>).map((map) {
          final lat = (map['latitude'] as num).toDouble();
          final lon = (map['longitude'] as num).toDouble();
          return CoordinatesEntityImpl(latitude: lat, longitude: lon);
        }).toList();

        final trackPath = _pathFactory.produce(trkCoords);

        return HikeEntityImpl(
          lastCoordinateTimestamp: DateTime.parse(data['lastCoordinateTimeStamp']),
          trackPath: trackPath,
          progressCoordinates: progressCoords,
        );
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
