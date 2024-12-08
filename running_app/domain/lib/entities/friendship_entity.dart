abstract class FriendshipEntity {
  final int id;
  final int requesterId;
  final int receiverId;
  final String requesterName;
  final String receiverName;

  FriendshipEntity(
      {required this.id,
      required this.requesterId,
      required this.receiverId,
      required this.requesterName,
      required this.receiverName});
}
