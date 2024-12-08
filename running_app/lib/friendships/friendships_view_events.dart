abstract class FriendshipsViewEvent {}

class SendFriendshipRequestEvent extends FriendshipsViewEvent {
  final int requesterId;
  final int receiverId;

  SendFriendshipRequestEvent({required this.requesterId, required this.receiverId});
}

class DeclineFriendshipRequestEvent extends FriendshipsViewEvent {
  final int requestId;

  DeclineFriendshipRequestEvent({required this.requestId});
}

class AcceptFriendshipRequestEvent extends FriendshipsViewEvent {
  final int requestId;

  AcceptFriendshipRequestEvent({required this.requestId});
}

class InitializeNotificationService extends FriendshipsViewEvent {
  final int userId;

  InitializeNotificationService({required this.userId});
}
