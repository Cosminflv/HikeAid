import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';

abstract class HikeEntity {
  DateTime get lastCoordinateTimestamp;
  PathEntity get trackPath;
  List<CoordinatesEntity> get progressCoordinates;
  LandmarkEntity get startLandmark;
  LandmarkEntity get endLandmark;
}
