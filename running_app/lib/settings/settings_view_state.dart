import 'package:domain/entities/coordinates_entity.dart';
import 'package:equatable/equatable.dart';

class CoordinatesImpl extends CoordinatesEntity {
  const CoordinatesImpl({required super.latitude, required super.longitude});

  @override
  double getDistanceTo(CoordinatesEntity coords) => throw UnimplementedError();
}

class SettingsViewState extends Equatable {
  final String prefferedMapStylePath;

  const SettingsViewState({this.prefferedMapStylePath = ''});

  @override
  List<Object?> get props => [prefferedMapStylePath];
}
