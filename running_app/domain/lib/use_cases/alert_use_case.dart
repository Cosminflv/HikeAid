import 'package:domain/entities/alert_entity.dart';
import 'package:domain/repositories/alert_repository.dart';

import 'dart:typed_data';

class AlertUseCase {
  final AlertRepository _alertRepository;

  AlertUseCase(this._alertRepository);

  Future<List<AlertEntity>> getAlerts() => _alertRepository.getAlerts();

  Future<bool> addAlert(
          {required String title,
          required String description,
          required EAlertType type,
          required double latitude,
          required double longitude,
          required Uint8List? image}) =>
      _alertRepository.addAlert(title, description, type, latitude, longitude, image);

  Future<bool> confirmAlert(int alertId) => _alertRepository.confirmAlert(alertId);

  Future<void> registerAlertsCallback(int userId, Function(List<AlertEntity>) onAlertsUpdated) async {
    await _alertRepository.registerAlertsCallback(userId, onAlertsUpdated);
  }

  Future<void> unregisterAlertsCallback() async => await _alertRepository.unregisterAlertsCallback();
}
