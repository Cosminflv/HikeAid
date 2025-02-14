import 'dart:typed_data';

import 'package:domain/entities/alert_entity.dart';

abstract class PendingAlertsRepository {
  Future<void> savePendingAlert(
      {required String description,
      required DateTime createdAt,
      required DateTime expiresAt,
      required double latitude,
      required double longitude,
      required String title,
      required Uint8List? image,
      required EAlertType type});
  Future<List<AlertEntity>> getPendingAlerts();
  Future<void> deletePendingAlert(String id);
}
