import 'package:domain/entities/alert_entity.dart';

abstract class AlertRepository {
  Future<List<AlertEntity>> getAlerts();
  void registerAlertsCallback(Function(List<AlertEntity>) onAlertsUpdated);

  void uploadAlert(AlertEntity alert);
  Future<bool> confirmAlert(AlertEntity alert);
}
