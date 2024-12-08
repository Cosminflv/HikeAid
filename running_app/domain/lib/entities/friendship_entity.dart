abstract class FriendshipEntity {
  final int id;
  final int requesterId;
  final int receiverId;
  final String requesterName;

  FriendshipEntity({
    required this.id,
    required this.requesterId,
    required this.receiverId,
    required this.requesterName,
  });
}
