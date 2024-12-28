import 'package:domain/entities/friendship_entity.dart';
import 'package:domain/repositories/friendship_repository.dart';

class FriendshipUseCase {
  final FriendshipRepository _friendshipRepository;

  FriendshipUseCase(this._friendshipRepository);

  Future<List<FriendshipEntity>> fetchRequests() async => await _friendshipRepository.fetchRequests();

  void initializeNotificationConnection(
      int userId, Function(String err, FriendshipEntity? friendshipEntity) onNotificationReceived) {
    _friendshipRepository.establishNotificationsConnection(userId, onNotificationReceived);
  }

  void closeNotificationsConnection() => _friendshipRepository.closeNotificationsConnection();

  Future<bool> declineFriendshipRequest(int requestId) async =>
      await _friendshipRepository.declineFriendshipRequest(requestId);

  Future<bool> sendFriendshipRequest(int receiverId) async => await _friendshipRepository.sendFriendRequest(receiverId);

  Future<bool> acceptFriendshipRequest(int requestId) async =>
      await _friendshipRepository.acceptFriendRequest(requestId);
}
