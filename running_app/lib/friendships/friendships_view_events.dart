import 'package:domain/entities/friendship_entity.dart';

abstract class FriendshipsViewEvent {}

class FetchRequestsEvent extends FriendshipsViewEvent {
  final int receiverId;

  FetchRequestsEvent({required this.receiverId});
}

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
  final FriendshipEntity request;

  AcceptFriendshipRequestEvent({required this.request});
}

class InitializeNotificationService extends FriendshipsViewEvent {
  final int userId;

  InitializeNotificationService({required this.userId});
}

class CloseNotificationService extends FriendshipsViewEvent {}
