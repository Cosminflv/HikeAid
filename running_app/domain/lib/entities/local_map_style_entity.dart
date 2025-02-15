import 'package:equatable/equatable.dart';

enum MapStyles { cycle, satellite, satelliteElevated, elevation, magicDay, magicNight }

abstract class LocalMapStyleEntity extends Equatable {
  final String path;
  final String previewPath;
  final MapStyles style;
  final bool hasElevation;

  LocalMapStyleEntity({required this.path, required this.previewPath, required this.style, required this.hasElevation});

  @override
  List<Object?> get props => [path, previewPath, style, hasElevation];
}
