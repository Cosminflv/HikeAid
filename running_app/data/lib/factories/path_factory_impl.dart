import 'package:data/models/path_entity_impl.dart';
import 'package:data/repositories_impl/extensions.dart';
import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/path_entity.dart';
import 'package:domain/factories/path_factory.dart';
import 'package:gem_kit/core.dart';

class PathFactoryImpl extends PathFactory {
  @override
  PathEntity produce(List<CoordinatesEntity> coordinates) =>
      PathEntityImpl(ref: Path.fromCoordinates(coordinates.map((e) => e.toGemCoordinates()).toList()));
}
