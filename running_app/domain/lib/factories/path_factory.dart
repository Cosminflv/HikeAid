import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/path_entity.dart';

abstract class PathFactory {
  PathEntity produce(List<CoordinatesEntity> coordinates);
}
