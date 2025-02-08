import 'package:domain/entities/alert_entity.dart';
import 'package:domain/repositories/alert_repository.dart';

import 'dart:typed_data';

class AlertUseCase {
  final AlertRepository _alertRepository;

  AlertUseCase(this._alertRepository);

  Future<List<AlertEntity>> getAlerts() => _alertRepository.getAlerts();

  Future<bool> addAlert(
          String title, String description, EAlertType type, double latitude, double longitude, Uint8List? image) =>
      _alertRepository.addAlert(title, description, type, latitude, longitude, image);

  Future<bool> confirmAlert(AlertEntity alert) => _alertRepository.confirmAlert(alert);

  void registerAlertsCallback(Function(List<AlertEntity>) onAlertsUpdated) {
    _alertRepository.registerAlertsCallback(onAlertsUpdated);
  }
}
