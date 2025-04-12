import 'package:domain/factories/path_factory.dart';
import 'package:gem_kit/core.dart';
import 'package:shared/data/path_entity_impl.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'package:shared/extensions.dart';

class PathFactoryImpl extends PathFactory {
  @override
  PathEntity produce(List<CoordinatesEntity> coordinates) =>
      PathEntityImpl(ref: Path.fromCoordinates(coordinates.map((e) => e.toGemCoordinates()).toList()));
}
