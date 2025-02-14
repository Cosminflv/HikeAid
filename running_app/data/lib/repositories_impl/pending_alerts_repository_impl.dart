import 'package:data/models/alert_entity_impl.dart';
import 'package:data/models/coordinates_entity_impl.dart';
import 'package:data/services/sembast_database.dart';
import 'package:domain/entities/alert_entity.dart';
import 'package:domain/repositories/pending_alerts_repository.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:typed_data';

class PendingAlertsRepositoryImpl extends PendingAlertsRepository {
  final _dbHelper = SembastDatabase.instance;

  @override
  Future<void> deletePendingAlert(int alertId) async {
    await _dbHelper.deleteAlert(alertId.toString());
  }

  @override
  Future<List<AlertEntity>> getPendingAlerts() async {
    final alerts = await _dbHelper.getAllAlerts();
    return alerts.map((snapshot) {
      final data = snapshot.value;
      return AlertEntityImpl(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt']),
        expiresAt: DateTime.fromMillisecondsSinceEpoch(data['expiresAt']),
        isActive: data['isActive'],
        coordinates: CoordinatesEntityImpl(
          latitude: data['latitude'],
          longitude: data['longitude'],
        ),
        type: EAlertType.fromInt(data['alertType']),
        authorId: data['authorId'],
        authorName: data['authorName'],
        confirmationsNumber: data['confirmationsNumber'],
        image: data['image'],
      );
    }).toList();
  }

  @override
  Future<void> savePendingAlert({
    required String description,
    required DateTime createdAt,
    required DateTime expiresAt,
    required double latitude,
    required double longitude,
    required String title,
    required Uint8List? image,
    required EAlertType type,
  }) async {
    final alertId = generateIntFromDateTime(createdAt);

    final alertData = {
      'id': alertId,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'expiresAt': expiresAt.millisecondsSinceEpoch,
      'isActive': true,
      'latitude': latitude,
      'longitude': longitude,
      'alertType': type.index,
      'authorId': 0,
      'authorName': 'Unknown',
      'confirmationsNumber': 0,
      'image': image
    };

    await _dbHelper.insertAlert(alertId.toString(), alertData);
  }

  String generateHash(String title, String description, DateTime createdAt) {
    final bytes = utf8.encode('$title$description${createdAt.toIso8601String()}');
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  int generateIntFromDateTime(DateTime dateTime) {
    final bytes = utf8.encode(dateTime.toIso8601String());
    final digest = sha256.convert(bytes);
    return digest.bytes.fold(0, (sum, byte) => sum + byte);
  }
}
