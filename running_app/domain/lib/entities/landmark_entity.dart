import 'dart:typed_data';

import 'package:domain/entities/coordinates_entity.dart';
import 'package:equatable/equatable.dart';

typedef LandmarkEntityList = List<LandmarkEntity>;

abstract class LandmarkEntity extends Equatable {
  final String name;
  final String address;
  final String? countryCode;
  final Uint8List? icon;

  final CoordinatesEntity coordinates;
  final bool isPositionBased;

  LandmarkEntity(
      {required this.name,
      required this.coordinates,
      required this.address,
      this.countryCode,
      this.icon,
      this.isPositionBased = false});

  Uint8List? get extraImage;
  void setImage(Uint8List image);

  int get id;

  @override
  List<Object?> get props => [coordinates, isPositionBased];
}
