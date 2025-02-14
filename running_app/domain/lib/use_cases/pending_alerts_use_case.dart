import 'dart:typed_data';

import 'package:domain/entities/alert_entity.dart';
import 'package:domain/repositories/pending_alerts_repository.dart';

class PendingAlertsUseCase {
  final PendingAlertsRepository pendingAlertsRepository;

  PendingAlertsUseCase(this.pendingAlertsRepository);

  Future<void> savePendingAlert(String title, String description, EAlertType type, double latitude, double longitude,
          Uint8List? image) async =>
      await pendingAlertsRepository.savePendingAlert(
          title: title,
          description: description,
          type: type,
          latitude: latitude,
          longitude: longitude,
          createdAt: DateTime.now(),
          expiresAt: DateTime.now().add(Duration(days: 2)),
          image: image);

  Future<List<AlertEntity>> getPendingAlerts() async => await pendingAlertsRepository.getPendingAlerts();

  Future<void> deletePendingAlert(int id) async {
    // Delete from storage after successful send
  }
}
