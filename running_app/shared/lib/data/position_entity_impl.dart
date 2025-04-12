import 'package:gem_kit/position.dart';

import '../domain/position_entity.dart';

class PositionEntityImpl extends PositionEntity {
  final GemPosition ref;
  PositionEntityImpl({required this.ref, required super.coordinates, required speed, required super.altitude})
      : super(speed: _calculateSpeed(ref.hasSpeed, speed));

  static double _calculateSpeed(bool hasSpeed, double speed) {
    return hasSpeed ? speed : 0;
  }

  @override
  bool get hasSpeed => ref.hasSpeed;
}
