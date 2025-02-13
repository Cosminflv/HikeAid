import 'package:domain/entities/alert_entity.dart';

class AlertState {
  final List<AlertEntity> alerts;
  final AlertEntity? mapSelectedAlert;
  final bool hasAdded;
  final bool hasConfirmed;

  AlertState({this.alerts = const [], this.hasAdded = false, this.hasConfirmed = false, this.mapSelectedAlert});

  AlertState copyWith({List<AlertEntity>? alerts, bool? isAdded, bool? isConfirmed, AlertEntity? pickedAlert}) {
    return AlertState(
        alerts: alerts ?? this.alerts,
        hasAdded: isAdded ?? hasAdded,
        hasConfirmed: isConfirmed ?? hasConfirmed,
        mapSelectedAlert: pickedAlert ?? mapSelectedAlert);
  }

  AlertState copyWithNullAlert() => AlertState(
        alerts: alerts,
        hasAdded: hasAdded,
        hasConfirmed: hasConfirmed,
        mapSelectedAlert: null,
      );
}
