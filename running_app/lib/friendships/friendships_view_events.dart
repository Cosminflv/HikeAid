import 'package:domain/entities/friendship_entity.dart';

abstract class FriendshipsViewEvent {}

class FetchRequestsEvent extends FriendshipsViewEvent {
  final int receiverId;

  FetchRequestsEvent({required this.receiverId});
}

class SendFriendshipRequestEvent extends FriendshipsViewEvent {
  final int receiverId;

  SendFriendshipRequestEvent(this.receiverId);
}

class DeclineFriendshipRequestEvent extends FriendshipsViewEvent {
  final FriendshipEntity request;

  DeclineFriendshipRequestEvent({required this.request});
}

class AcceptFriendshipRequestEvent extends FriendshipsViewEvent {
  final FriendshipEntity request;

  AcceptFriendshipRequestEvent({required this.request});
}

class InitializeNotificationService extends FriendshipsViewEvent {
  final int userId;

  InitializeNotificationService({required this.userId});
}

class CloseNotificationService extends FriendshipsViewEvent {}
