import 'package:domain/entities/alert_entity.dart';

class AlertState {
  final List<AlertEntity> alerts;

  AlertState({this.alerts = const []});

  AlertState copyWith({List<AlertEntity>? alerts}) {
    return AlertState(alerts: alerts ?? this.alerts);
  }
}
