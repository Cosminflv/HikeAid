import 'package:domain/entities/coordinates_entity.dart';

class CoordinatesImpl extends CoordinatesEntity {
  const CoordinatesImpl({required super.latitude, required super.longitude});

  @override
  double getDistanceTo(CoordinatesEntity coords) => throw UnimplementedError();
}
