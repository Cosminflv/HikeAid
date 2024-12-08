import 'package:domain/entities/friendship_entity.dart';
import 'package:domain/repositories/friendship_repository.dart';

class FriendshipUseCase {
  final FriendshipRepository _friendshipRepository;

  FriendshipUseCase(this._friendshipRepository);

  void initializeNotificationConnection(
      int userId, Function(String err, FriendshipEntity? friendshipEntity) onNotificationReceived) {
    _friendshipRepository.establishNotificationsConnection(userId, onNotificationReceived);
  }

  Future<bool> declineFriendshipRequest(int requestId) async =>
      await _friendshipRepository.declineFriendshipRequest(requestId);

  Future<bool> sendFriendshipRequest(int requesterId, int receiverId) async =>
      await _friendshipRepository.sendFriendRequest(requesterId: requesterId, receiverId: receiverId);

  Future<bool> acceptFriendshipRequest(int requestId) async =>
      await _friendshipRepository.acceptFriendRequest(requestId);
}
