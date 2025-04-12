import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'coordinates_entity.dart';

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
  bool get hasExtraImage;

  Uint8List? get image;

  int get id;

  LandmarkEntity copy({Uint8List? image});

  @override
  List<Object?> get props => [coordinates, isPositionBased];
}
