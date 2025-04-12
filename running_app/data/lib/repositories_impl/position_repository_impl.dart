import 'package:data/repositories_impl/extensions.dart';
import 'package:domain/repositories/position_repository.dart';

import 'package:gem_kit/sense.dart';
import 'package:gem_kit/src/position/gem_position_listener_impl.dart';

import 'package:rxdart/rxdart.dart';
import 'package:shared/domain/position_entity.dart';

class PositionRepositoryImpl extends PositionRepository {
  final BehaviorSubject<PositionEntity?> _positionStreamController = BehaviorSubject.seeded(null);
  GemPositionListener? _positionListener;

  PositionRepositoryImpl();

  // Streams
  @override
  Stream<PositionEntity?> get positionStream => _positionStreamController.stream;

  // Current Position
  @override
  PositionEntity? get position => _positionStreamController.stream.value;

  // Set Position
  @override
  Future<void> setLivePosition() async {
    PositionService.instance.setLiveDataSource();
    _initializeFirstPosition();
    _listenForPositionUpdate();
  }

  @override
  void cancelPositionListener() {
    if (_positionListener != null) {
      PositionService.instance.removeListener(_positionListener!);
    }
  }

  void _listenForPositionUpdate() {
    _positionListener = PositionService.instance.addPositionListener((gemPosition) {
      final positionEntity = gemPosition.toEntityImpl();
      _positionStreamController.add(positionEntity);
    });
  }

  void _initializeFirstPosition() {
    final initialPosition = PositionService.instance.getPosition();
    final positionEntity = initialPosition?.toEntityImpl();
    _positionStreamController.add(positionEntity);
  }
}
