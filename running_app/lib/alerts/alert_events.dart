import 'dart:typed_data';

import 'package:domain/entities/alert_entity.dart';

class AlertEvent {}

class FetchAlertsEvent extends AlertEvent {}

class ConfirmAlertEvent extends AlertEvent {
  final int alertId;

  ConfirmAlertEvent(this.alertId);
}

class InvalidateAlertEvent extends AlertEvent {
  final int alertId;

  InvalidateAlertEvent(this.alertId);
}

class ResetHasConfirmedEvent extends AlertEvent {}

class RegisterAlertsSubscription extends AlertEvent {}

class AlertSelectedEvent extends AlertEvent {
  final AlertEntity pickedAlert;

  AlertSelectedEvent({required this.pickedAlert});
}

class AlertUnselectedEvent extends AlertEvent {}

class AddAlertEvent extends AlertEvent {
  final String title;
  final String description;
  final EAlertType type;
  final double latitude;
  final double longitude;
  final Uint8List? image;

  AddAlertEvent(
      {required this.title,
      required this.description,
      required this.type,
      required this.latitude,
      required this.longitude,
      required this.image});
}

class RetryPendingAlertsEvent extends AlertEvent {}
