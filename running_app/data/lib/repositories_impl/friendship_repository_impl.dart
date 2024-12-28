import 'package:built_collection/built_collection.dart';
import 'package:data/models/friendship_entity_impl.dart';
import 'package:domain/entities/friendship_entity.dart';
import 'package:domain/repositories/friendship_repository.dart';
import 'package:openapi/openapi.dart';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:core/config.dart';

import 'dart:convert';

class FriendshipRepositoryImpl extends FriendshipRepository {
  final Openapi _openapi;

  FriendshipRepositoryImpl(this._openapi);

  IOWebSocketChannel? _ioChannel;
  WebSocketChannel? _webChannel;

  bool _isClosing = false; // Flag to indicate intentional closure

  @override
  Future<List<FriendshipEntity>> fetchRequests() async {
    try {
      final result = await _openapi.getUserApi().apiUserGetFriendRequestsGet();
      if (result.statusCode == 200) {
        final requests = result.data as BuiltList<FriendshipDto>;
        List<FriendshipEntity> requestList = [];
        for (FriendshipDto request in requests) {
          requestList.add(FriendshipEntityImpl.fromDto(request));
        }
        return requestList;
      }
    } catch (e) {
      print(e);
      return [];
    }
    return [];
  }

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
    _isClosing = false; // Reset the flag

    // Connect to the WebSocket server
    if (!kIsWeb) {
      _ioChannel = IOWebSocketChannel.connect(
        Uri.parse('ws://$ipv4Address:7011/ws?userId=$userId'),
      );
    } else {
      _webChannel = WebSocketChannel.connect(Uri.parse('ws://$ipv4Address:7011/ws?userId=$userId'));
    }

    // Listen for incoming messages
    if (!kIsWeb) {
      _ioChannel!.stream.listen(
        (message) {
          final decodedMessage = jsonDecode(message);
          onNotificationReceived(
              "success",
              FriendshipEntityImpl(
                id: decodedMessage['id'],
                requesterId: decodedMessage['requesterId'],
                receiverId: decodedMessage['receiverId'],
                requesterName: decodedMessage['requesterName'],
              ));
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
      _webChannel!.stream.listen(
        (message) {
          var decodedMessage = jsonDecode(message);
          onNotificationReceived(
              "success",
              FriendshipEntityImpl(
                id: decodedMessage['id'],
                requesterId: decodedMessage['requesterId'],
                receiverId: decodedMessage['receiverId'],
                requesterName: decodedMessage['requesterName'],
              ));
        },
        onError: (error) {
          onNotificationReceived(
              "Error: $error",
              FriendshipEntityImpl(
                id: 0,
                requesterId: 0,
                receiverId: 0,
                requesterName: "err",
              ));
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
    if (_isClosing) return; // Do not reconnect if the disconnection is intentional

    // Retry connection after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      establishNotificationsConnection(userId, onNotificationReceived);
    });
  }

  @override
  Future<bool> sendFriendRequest(int receiverId) async {
    try {
      await _openapi.getUserApi().apiUserSendFriendRequestPost(receiverId: receiverId);
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

  @override
  void closeNotificationsConnection() {
    _isClosing = true;

    if (_ioChannel != null) {
      _ioChannel!.sink.close();
      _ioChannel = null;
    }

    if (_webChannel != null) {
      _webChannel!.sink.close();
      _webChannel = null;
    }
  }
}
