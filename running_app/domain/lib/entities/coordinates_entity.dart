import 'package:equatable/equatable.dart';

abstract class CoordinatesEntity extends Equatable {
  final double latitude;
  final double longitude;

  double getDistanceTo(CoordinatesEntity coords);
  const CoordinatesEntity({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
