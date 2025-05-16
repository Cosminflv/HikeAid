import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:core/config.dart';
import 'dart:convert';

class WebSocketService {
  late WebSocketChannel _channel;
  final int userId;

  WebSocketService({required this.userId});

  void connect() {
    _channel = IOWebSocketChannel.connect(
      Uri.parse('ws://$ipv4Address:7011/ws?userId=$userId'),
      pingInterval: const Duration(seconds: 30),
    );

    _channel.stream.listen(
      (message) {
        // Handle incoming messages from server
        print('Received: $message');
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      onDone: () {
        print('WebSocket connection closed');
      },
    );
  }

  void sendCoordinate(CoordinatePredictionDto coordinate) {
    final message = jsonEncode({
      'Latitude': coordinate.latitude,
      'Longitude': coordinate.longitude,
      'Elevation': coordinate.elevation,
      'Time': coordinate.time.toIso8601String(),
    });

    _channel.sink.add(message);
  }

  void dispose() {
    _channel.sink.close();
  }
}

// DTO class
class CoordinatePredictionDto {
  final double latitude;
  final double longitude;
  final double elevation;
  final DateTime time;

  CoordinatePredictionDto({
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.time,
  });
}
