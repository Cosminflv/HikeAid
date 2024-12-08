import 'package:domain/entities/friendship_entity.dart';

abstract class FriendshipRepository {
  void establishNotificationsConnection(
      int userId, Function(String err, FriendshipEntity? friendshipEntity) onNotificationReceived);
  Future<bool> declineFriendshipRequest(int requestId);
  Future<bool> sendFriendRequest({required int requesterId, required int receiverId});
  Future<bool> acceptFriendRequest(int requestId);
}
