import 'package:domain/entities/alert_entity.dart';

class AlertState {
  final List<AlertEntity> alerts;
  final AlertEntity? mapSelectedAlert;
  final bool hasAdded;
  final bool hasConfirmed;
  final bool hasAddedToPending;
  AlertState({
    this.alerts = const [],
    this.hasAdded = false,
    this.hasConfirmed = false,
    this.hasAddedToPending = false,
    this.mapSelectedAlert,
  });

  AlertState copyWith(
      {List<AlertEntity>? alerts, bool? isAdded, bool? isConfirmed, bool? hasPended, AlertEntity? pickedAlert}) {
    return AlertState(
        alerts: alerts ?? this.alerts,
        hasAdded: isAdded ?? hasAdded,
        hasConfirmed: isConfirmed ?? hasConfirmed,
        hasAddedToPending: hasPended ?? hasAddedToPending,
        mapSelectedAlert: pickedAlert ?? mapSelectedAlert);
  }

  AlertState copyWithNullAlert() => AlertState(
        alerts: alerts,
        hasAdded: hasAdded,
        hasConfirmed: hasConfirmed,
        hasAddedToPending: hasAddedToPending,
        mapSelectedAlert: null,
      );
}
