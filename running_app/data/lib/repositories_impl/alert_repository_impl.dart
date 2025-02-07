import 'package:data/models/alert_entity_impl.dart';
import 'package:data/models/coordinates_entity_impl.dart';
import 'package:domain/entities/alert_entity.dart';
import 'package:domain/repositories/alert_repository.dart';
import 'package:flutter/services.dart';
import 'package:openapi/openapi.dart';

class AlertRepositoryImpl extends AlertRepository {
  final Openapi _openapi;
  //final GemMapController _mapController;

  AlertRepositoryImpl(this._openapi);

  @override
  Future<bool> confirmAlert(AlertEntity alert) async {
    // try {
    //   final result = await _openapi.getAlertApi().ap (alert.id);
    // } catch (e) {
    //   print(e);
    // }

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
        final image = await _getAlertImage(e['id']);
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
          alertType: EAlertType.fromInt(e['alertType']),
          authorId: e['authorId'],
          authorName: authorName,
          confirmationsNumber: e['confirmedUserIds'].length,
          image: image,
        );
      }).toList());
      return alerts;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  void registerAlertsCallback(Function(List<AlertEntity> p1) onAlertsUpdated) {
    // TODO: implement registerAlertsCallback
  }

  @override
  Future<bool> uploadAlert(AlertEntity alert) async {
    try {
      final result = await _openapi.getAlertApi().apiAlertAddAlertPost(
          createdAt: alert.createdAt,
          expiresAt: alert.expiresAt,
          title: alert.title,
          description: alert.description,
          alertType: alert.alertType.toString(),
          isActive: alert.isActive,
          latitude: alert.coordinates.latitude,
          longitude: alert.coordinates.longitude);
      return result.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Uint8List> _getAlertImage(int id) async {
    final result = await _openapi.getAlertApi().apiAlertAlertIdImageGet(alertId: id);
    Uint8List image;
    if (result.statusCode != 200) {
      final ByteData data = await rootBundle.load("assets/default_alert.png");
      image = data.buffer.asUint8List();
    } else {
      image = Uint8List.fromList(result.data as List<int>);
    }
    return image;
  }

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
}
