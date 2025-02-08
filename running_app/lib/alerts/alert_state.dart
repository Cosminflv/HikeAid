import 'package:domain/entities/alert_entity.dart';

class AlertState {
  final List<AlertEntity> alerts;
  final bool hasAdded;

  AlertState({this.alerts = const [], this.hasAdded = false});

  AlertState copyWith({List<AlertEntity>? alerts, bool? isAdded}) {
    return AlertState(alerts: alerts ?? this.alerts, hasAdded: isAdded ?? hasAdded);
  }
}
