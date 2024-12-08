import 'package:domain/entities/friendship_entity.dart';

abstract class FriendshipRepository {
  Future<List<FriendshipEntity>> fetchRequests(int receiverId);

  void establishNotificationsConnection(
      int userId, Function(String err, FriendshipEntity? friendshipEntity) onNotificationReceived);

  void closeNotificationsConnection();
  Future<bool> declineFriendshipRequest(int requestId);
  Future<bool> sendFriendRequest({required int requesterId, required int receiverId});
  Future<bool> acceptFriendRequest(int requestId);
}
