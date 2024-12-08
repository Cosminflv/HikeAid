import 'package:data/models/friendship_entity_impl.dart';
import 'package:domain/entities/friendship_entity.dart';
import 'package:domain/repositories/friendship_repository.dart';
import 'package:openapi/openapi.dart';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'dart:convert';

class FriendshipRepositoryImpl extends FriendshipRepository {
  final Openapi _openapi;

  FriendshipRepositoryImpl(this._openapi);
  @override
  Future<bool> declineFriendshipRequest(int requestId) async {
    try {
      await _openapi.getUserApi().apiUserDeclineFriendRequestPost(requestId: requestId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void establishNotificationsConnection(
      int userId, Function(String err, FriendshipEntity? entity) onNotificationReceived) {
    late IOWebSocketChannel channel;
    late WebSocketChannel webChannel;

    // Connect to the WebSocket server
    if (!kIsWeb) {
      channel = IOWebSocketChannel.connect(
        Uri.parse('ws://192.168.1.5:7011/ws?userId=$userId'),
      );
    } else {
      webChannel = WebSocketChannel.connect(Uri.parse('ws://192.168.1.5:7011/ws?userId=$userId'));
    }

    // Listen for incoming messages
    if (!kIsWeb) {
      channel.stream.listen(
        (message) {
          final decodedMessage = jsonDecode(message);
          onNotificationReceived(
              "success",
              FriendshipEntityImpl(
                  id: decodedMessage['id'],
                  requesterId: decodedMessage['requesterId'],
                  receiverId: decodedMessage['receiverId'],
                  requesterName: decodedMessage['requesterName'],
                  receiverName: decodedMessage['receiverName']));
        },
        onError: (error) {
          onNotificationReceived("Error: $error", null);
          print('WebSocket error: $error');
          _reconnect(userId, onNotificationReceived);
        },
        onDone: () {
          print('WebSocket closed');
          _reconnect(userId, onNotificationReceived);
        },
      );
    } else {
      webChannel.stream.listen(
        (message) {
          var decodedMessage = jsonDecode(message);
          onNotificationReceived(
              "success",
              FriendshipEntityImpl(
                  id: decodedMessage['id'],
                  requesterId: decodedMessage['requesterId'],
                  receiverId: decodedMessage['receiverId'],
                  requesterName: decodedMessage['requesterName'],
                  receiverName: decodedMessage['receiverName']));
        },
        onError: (error) {
          onNotificationReceived("Error: $error",
              FriendshipEntityImpl(id: 0, requesterId: 0, receiverId: 0, requesterName: "err", receiverName: "err"));
          print('WebSocket error: $error');
          _reconnect(userId, onNotificationReceived);
        },
        onDone: () {
          onNotificationReceived("Socket closed", null);
          print('WebSocket closed');
        },
      );
    }
  }

  void _reconnect(int userId, Function(String err, FriendshipEntity? entity) onNotificationReceived) {
    // Retry connection after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      establishNotificationsConnection(userId, onNotificationReceived);
    });
  }

  @override
  Future<bool> sendFriendRequest({required int requesterId, required int receiverId}) async {
    try {
      await _openapi.getUserApi().apiUserSendFriendRequestPost(requesterId: requesterId, receiverId: receiverId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> acceptFriendRequest(int requestId) async {
    try {
      await _openapi.getUserApi().apiUserAcceptFriendRequestPost(requestId: requestId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
