import 'package:domain/entities/coordinates_entity.dart';
import 'package:equatable/equatable.dart';

class MapCameraStateEntity extends Equatable {
  final CoordinatesEntity coordinates;
  final int zoom;

  const MapCameraStateEntity({required this.coordinates, required this.zoom});

  @override
  List<Object?> get props => [coordinates, zoom];
}
