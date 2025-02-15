
import 'package:core/config.dart';
import 'package:domain/entities/alert_entity.dart';

import 'package:gem_kit/core.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:convert';

class AlertEntityImpl extends AlertEntity {
  AlertEntityImpl(
      {required super.id,
      required super.title,
      required super.description,
      required super.createdAt,
      required super.expiresAt,
      required super.isActive,
      required super.coordinates,
      required super.type,
      required super.authorId,
      required super.image,
      required super.authorName,
      required super.confirmationsNumber});

  Coordinates toGemCoordinates() => Coordinates(latitude: coordinates.latitude, longitude: coordinates.longitude);

  @override
  Future<Uint8List?> loadImage() async {  
    final baseUrl = "http://$ipv4Address:7011/api/Alert/$id/image";

    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Accept': 'image/jpeg'},
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching image: $e');
      return null;
    }
  }

  @override
  Future<int> loadConfirmationsNumber() async {
    final baseUrl = "http://$ipv4Address:7011/api/Alert/$id/confirmations";

    try {
      final response = await http.get(Uri.parse(baseUrl), headers: {'accept': '*/*'});

      if (response.statusCode == 200) {
        final List<int> resList = List<int>.from(jsonDecode(response.body));
        return resList.length;
      } else if (response.statusCode == 404) {
        return 0;
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching image: $e');
      return 0;
    }
  }
}
