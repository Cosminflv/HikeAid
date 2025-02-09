import 'package:domain/entities/alert_entity.dart';

class AlertState {
  final List<AlertEntity> alerts;
  final AlertEntity? mapSelectedAlert;
  final bool hasAdded;

  AlertState({this.alerts = const [], this.hasAdded = false, this.mapSelectedAlert});

  AlertState copyWith({List<AlertEntity>? alerts, bool? isAdded, AlertEntity? pickedAlert}) {
    return AlertState(
        alerts: alerts ?? this.alerts,
        hasAdded: isAdded ?? hasAdded,
        mapSelectedAlert: pickedAlert ?? mapSelectedAlert);
  }

  AlertState copyWithNullAlert() => AlertState(alerts: alerts, hasAdded: hasAdded, mapSelectedAlert: null);
}
