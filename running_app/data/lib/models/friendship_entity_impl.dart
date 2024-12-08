import 'package:domain/entities/friendship_entity.dart';

class FriendshipEntityImpl extends FriendshipEntity {
  FriendshipEntityImpl(
      {required super.id,
      required super.requesterId,
      required super.receiverId,
      required super.requesterName,
      required super.receiverName});
}
