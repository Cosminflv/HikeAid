import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/path_entity.dart';

abstract class PathFactory {
  PathEntity produce(List<CoordinatesEntity> coordinates);
}
