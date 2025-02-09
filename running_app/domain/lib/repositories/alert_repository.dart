import 'dart:typed_data';

import 'package:domain/entities/alert_entity.dart';

abstract class AlertRepository {
  Future<List<AlertEntity>> getAlerts();
  Future<bool> addAlert(
      String title, String description, EAlertType type, double latitude, double longitude, Uint8List? image);
  void registerAlertsCallback(Function(List<AlertEntity>) onAlertsUpdated);
  void unregisterAlertsCallback();

  void uploadAlert(AlertEntity alert);
  Future<bool> confirmAlert(AlertEntity alert);
}
