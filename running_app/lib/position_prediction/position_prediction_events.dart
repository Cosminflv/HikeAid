abstract class PositionPredictionEvent {}

class ImportGPXDemoEvent extends PositionPredictionEvent {
  String assetsFilePath;

  ImportGPXDemoEvent(this.assetsFilePath);
}

class ConfirmHikeEvent extends PositionPredictionEvent {
  final bool hasConfirmedHike;

  ConfirmHikeEvent(this.hasConfirmedHike);
}
