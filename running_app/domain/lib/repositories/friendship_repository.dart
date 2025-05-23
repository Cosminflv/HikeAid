import 'package:domain/entities/friendship_entity.dart';

abstract class FriendshipRepository {
  Future<List<FriendshipEntity>> fetchRequests();

  Future<void> establishNotificationsConnection(
      int userId, Function(String err, FriendshipEntity? friendshipEntity) onNotificationReceived);

  Future<void> closeNotificationsConnection();
  Future<bool> declineFriendshipRequest(int requestId);
  Future<bool> sendFriendRequest(int receiverId);
  Future<bool> acceptFriendRequest(int requestId);
}
