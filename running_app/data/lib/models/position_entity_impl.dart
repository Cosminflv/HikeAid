import 'package:domain/entities/position_entity.dart';
import 'package:gem_kit/position.dart';

class PositionEntityImpl extends PositionEntity {
  final GemPosition ref;
  PositionEntityImpl({required this.ref, required super.coordinates, required speed, required super.altitude})
      : super(speed: _calculateSpeed(ref.hasSpeed, speed));

  static double _calculateSpeed(bool hasSpeed, double speed) {
    return hasSpeed ? speed : 0;
  }

  @override
  // TODO: implement hasSpeed
  bool get hasSpeed => ref.hasSpeed;
}
