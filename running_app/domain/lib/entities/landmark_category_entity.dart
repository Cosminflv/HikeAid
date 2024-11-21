import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class LandmarkCategoryEntity extends Equatable {
  final int id;
  final String name;
  final Uint8List? icon;

  LandmarkCategoryEntity({required this.id, required this.icon, required this.name});

  @override
  List<Object> get props => [id];
}
