import 'package:domain/entities/alert_entity.dart';
import 'package:domain/repositories/alert_repository.dart';

class AlertUseCase {
  final AlertRepository _alertRepository;

  AlertUseCase(this._alertRepository);

  Future<List<AlertEntity>> getAlerts() => _alertRepository.getAlerts();

  Future<bool> confirmAlert(AlertEntity alert) => _alertRepository.confirmAlert(alert);

  void registerAlertsCallback(Function(List<AlertEntity>) onAlertsUpdated) {
    _alertRepository.registerAlertsCallback(onAlertsUpdated);
  }
}
