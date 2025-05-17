import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/hike_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';

class HikeEntityImpl extends HikeEntity {
  @override
  DateTime lastCoordinateTimestamp;

  @override
  PathEntity trackPath;

  @override
  List<CoordinatesEntity> progressCoordinates;

  HikeEntityImpl({
    required this.lastCoordinateTimestamp,
    required this.trackPath,
    required this.progressCoordinates,
  });

  @override
  // TODO: implement endLandmark
  LandmarkEntity get endLandmark => throw UnimplementedError();

  @override
  // TODO: implement startLandmark
  LandmarkEntity get startLandmark => throw UnimplementedError();
}
