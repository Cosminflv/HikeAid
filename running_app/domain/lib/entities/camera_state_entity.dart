import 'package:equatable/equatable.dart';
import 'package:shared/domain/coordinates_entity.dart';

class MapCameraStateEntity extends Equatable {
  final CoordinatesEntity coordinates;
  final int zoom;

  const MapCameraStateEntity({required this.coordinates, required this.zoom});

  @override
  List<Object?> get props => [coordinates, zoom];
}
