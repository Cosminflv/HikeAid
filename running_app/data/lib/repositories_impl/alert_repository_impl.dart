import 'package:data/models/alert_entity_impl.dart';
import 'package:data/utils/sse_client.dart';
import 'package:domain/entities/alert_entity.dart';
import 'package:domain/repositories/alert_repository.dart';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:openapi/openapi.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared/data/coordinates_entity_impl.dart';

class AlertRepositoryImpl extends AlertRepository {
  final Openapi _openapi;
  final SSEClient _sseClient;
  StreamSubscription? _sseSubscription;
  //final GemMapController _mapController;

  AlertRepositoryImpl(this._openapi, this._sseClient);

  @override
  Future<bool> confirmAlert(int alertId) async {
    try {
      final result = await _openapi.getAlertApi().apiAlertAlertIdConfirmAlertPost(alertId: alertId);

      if (result.statusCode != 200) return false;

      return (result.data as bool);
    } catch (e) {
      print(e);
    }

    return false;
  }

  @override
  Future<List<AlertEntity>> getAlerts() async {
    try {
      final result = await _openapi.getAlertApi().apiAlertGetAllAlertsGet();

      if (result.statusCode != 200) {
        return [];
      }

      final data = result.data as List<dynamic>;

      final alerts = await Future.wait(data.map((e) async {
        e as Map<String, dynamic>;
        final authorName = await _getAlertAuthorName(e['authorId']);

        return AlertEntityImpl(
          id: e['id'],
          title: e['title'],
          description: e['description'],
          createdAt: DateTime.parse(e['createdAt']),
          expiresAt: DateTime.parse(e['expiresAt']),
          isActive: e['isActive'],
          coordinates: CoordinatesEntityImpl(
            latitude: e['latitude'],
            longitude: e['longitude'],
          ),
          type: EAlertType.fromInt(e['alertType']),
          authorId: e['authorId'],
          authorName: authorName,
          confirmationsNumber: e['confirmedUserIds'].length,
          image: null,
        );
      }).toList());
      return alerts;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<bool> addAlert(
      String title, String description, EAlertType type, double latitude, double longitude, Uint8List? image) async {
    try {
      final expireDate = _calculateExpireDate(type);
      final result = await _openapi.getAlertApi().apiAlertAddAlertPost(
          createdAt: DateTime.now().toUtc(),
          expiresAt: expireDate.toUtc(),
          title: title,
          description: description,
          alertType: type.name,
          isActive: true,
          latitude: latitude,
          longitude: longitude,
          imageFile: image != null ? MultipartFile.fromBytes(image.toList(), filename: 'image.png') : null);

      if (result.statusCode != 200) {
        return false;
      }
      print("RETURNED TRUE addAlert API CALL\n");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<void> registerAlertsCallback(Function(List<AlertEntity> p1) onAlertsUpdated) async {
    Future<void> startListening() async {
      await _sseSubscription?.cancel(); // Cancel previous subscription (if any)
      _sseSubscription = _sseClient.subscribe().listen(
        (data) async {
          try {
            final jsonString = data.trim();

            if (jsonString.isEmpty) {
              print("Received an empty or invalid event.");
              return;
            }

            final Map<String, dynamic> jsonData = jsonDecode(jsonString);
            print(data);

            final authorName = await _getAlertAuthorName(jsonData['authorId']);

            final alert = AlertEntityImpl(
              id: jsonData['alertId'],
              title: jsonData['alertTitle'],
              description: jsonData['alertDescription'],
              createdAt: DateTime.parse(jsonData['alertCreatedAt']),
              expiresAt: DateTime.parse(jsonData['alertExpiresAt']),
              isActive: jsonData['alertIsActive'],
              coordinates: CoordinatesEntityImpl(
                latitude: jsonData['alertLatitude'],
                longitude: jsonData['alertLongitude'],
              ),
              type: EAlertType.fromInt(jsonData['alertType']),
              authorId: jsonData['authorId'],
              image: null,
              authorName: authorName,
              confirmationsNumber: jsonData['confirmations'],
            );

            onAlertsUpdated([alert]);
          } catch (e, stack) {
            print("Error processing SSE event: $e\n$stack");
          }
        },
        onError: (error) {
          print("SSE Connection Error: $error");
        },
        onDone: () {
          print("SSE Connection Closed.");
        },
        cancelOnError: true,
      );
    }

    await startListening(); // Start listening to SSE
  }

  @override
  Future<void> unregisterAlertsCallback() async {
    if (_sseSubscription != null) {
      await _sseSubscription!.cancel();
      _sseSubscription = null;
    }
  }

  @override
  Future<bool> uploadAlert(AlertEntity alert) async {
    try {
      final result = await _openapi.getAlertApi().apiAlertAddAlertPost(
          createdAt: alert.createdAt,
          expiresAt: alert.expiresAt,
          title: alert.title,
          description: alert.description,
          alertType: alert.type.toString(),
          isActive: alert.isActive,
          latitude: alert.coordinates.latitude,
          longitude: alert.coordinates.longitude);
      return result.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<Uint8List> _getAlertImage(int id) async {
  //   final result = await _openapi.getAlertApi().apiAlertAlertIdImageGet(alertId: id);
  //   Uint8List image;
  //   if (result.statusCode != 200) {
  //     final ByteData data = await rootBundle.load("assets/default_alert.png");
  //     image = data.buffer.asUint8List();
  //   } else {
  //     image = Uint8List.fromList(result.data as List<int>);
  //   }
  //   return image;
  // }

  Future<String> _getAlertAuthorName(int userId) async {
    try {
      final result = await _openapi.getUserApi().apiUserIdGetUserGet(id: userId);

      if (result.statusCode != 200) {
        return 'Unknown';
      }

      final data = result.data as Map<String, dynamic>;
      return data['username'];
    } catch (e) {
      print(e);
      return 'Unknown';
    }
  }

  DateTime _calculateExpireDate(EAlertType type) {
    var date = DateTime.now();
    switch (type) {
      case EAlertType.dangerousWeather:
        return date.add(Duration(days: 3));
      case EAlertType.roadBlock:
        return date.add(Duration(days: 1));
      case EAlertType.wildAnimals:
        return date.add(Duration(days: 3));
      case EAlertType.personalEmergency:
        return date.add(Duration(days: 1));
      case EAlertType.other:
        return date.add(Duration(days: 1));
    }
  }
}
