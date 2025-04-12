import 'coordinates_entity.dart';

typedef PathEntityList = List<PathEntity>;

abstract class PathEntity {
  List<CoordinatesEntity> get coordinates;
}
