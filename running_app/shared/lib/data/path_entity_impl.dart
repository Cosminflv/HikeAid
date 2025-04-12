import 'package:gem_kit/core.dart';
import 'package:shared/data/coordinates_entity_impl.dart';
import 'package:shared/domain/coordinates_entity.dart';

import '../domain/path_entity.dart';

class PathEntityImpl implements PathEntity {
  final Path ref;

  PathEntityImpl({required this.ref});

  @override
  List<CoordinatesEntity> get coordinates => ref.coordinates
      .map((coordinate) => CoordinatesEntityImpl(latitude: coordinate.latitude, longitude: coordinate.longitude))
      .toList();
}
