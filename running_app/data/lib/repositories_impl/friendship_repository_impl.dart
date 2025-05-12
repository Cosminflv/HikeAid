import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:data/models/friendship_entity_impl.dart';
import 'package:data/utils/sse_client.dart';
import 'package:domain/entities/friendship_entity.dart';
import 'package:domain/repositories/friendship_repository.dart';
import 'package:openapi/openapi.dart';

import 'package:core/config.dart';

import 'dart:convert';

class FriendshipRepositoryImpl extends FriendshipRepository {
  final Openapi _openapi;

  late SSEClient _sseClient;
  StreamSubscription? _sseSubscription;

  FriendshipRepositoryImpl(this._openapi);

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
      final response = await _openapi.getUserApi().apiUserDeclineFriendRequestPost(requestId: requestId);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<void> establishNotificationsConnection(
      int userId, Function(String err, FriendshipEntity? entity) onNotificationReceived) async {
    _sseClient = SSEClient(
      url: 'http://$ipv4Address:7011/Events/stream/friendships?userId=$userId',
      headers: {'Accept': 'text/event-stream'},
    );

    Future<void> startListening() async {
      await _sseSubscription?.cancel(); // Cancel previous subscription (if any)
      _sseSubscription = _sseClient.subscribe().listen(
        (data) async {
          try {
            final lines = data.split('\n');

            // Extract lines starting with "data: " and remove the prefix
            final jsonString = lines
                .where((line) => line.startsWith('data: '))
                .map((line) => line.substring(6)) // Remove "data: " prefix
                .join('\n') // Rebuild JSON string
                .trim();

            if (jsonString.isEmpty) {
              print("Received empty data payload");
              return;
            }

            final Map<String, dynamic> jsonData = jsonDecode(jsonString);

            onNotificationReceived(
                "success",
                FriendshipEntityImpl(
                  id: jsonData['id'],
                  requesterId: jsonData['requesterId'],
                  receiverId: jsonData['receiverId'],
                  requesterName: jsonData['requesterName'],
                ));
            print(data);
          } catch (e) {
            print("Error parsing SSE data: $e");
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
  Future<bool> sendFriendRequest(int receiverId) async {
    try {
      final response = await _openapi.getUserApi().apiUserSendFriendRequestPost(recivId: receiverId);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> acceptFriendRequest(int requestId) async {
    try {
      final response = await _openapi.getUserApi().apiUserAcceptFriendRequestPost(requestId: requestId);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<void> closeNotificationsConnection() async {
    if (_sseSubscription != null) {
      await _sseSubscription!.cancel();
      _sseSubscription = null;
    }
  }
}
