import 'package:domain/entities/position_entity.dart';

abstract class PositionRepository {
  // Streams
  Stream<PositionEntity?> get positionStream;

  // Current Position
  PositionEntity? get position;

  // Set Position
  Future<void> setLivePosition();

  void cancelPositionListener();
}
