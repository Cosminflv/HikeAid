import 'package:shared/domain/tour_entity.dart';

abstract class PositionPredictionEvent {}

class ImportGPXDemoEvent extends PositionPredictionEvent {
  String assetsFilePath;

  ImportGPXDemoEvent(this.assetsFilePath);
}

class ConfirmHikeEvent extends PositionPredictionEvent {
  final bool hasConfirmedHike;

  ConfirmHikeEvent(this.hasConfirmedHike);
}

class GetCurrentHikeEvent extends PositionPredictionEvent {
  final int userId;

  GetCurrentHikeEvent(this.userId);
}

class ReisterPositionTransferEvent extends PositionPredictionEvent {
  final int userId;

  ReisterPositionTransferEvent(this.userId);
}

class UnregisterPositionTransferEvent extends PositionPredictionEvent {}

class SendCoordinatesEvent extends PositionPredictionEvent {
  final CoordinatesWithTimestamp coordinates;

  SendCoordinatesEvent(this.coordinates);
}
