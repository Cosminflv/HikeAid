import 'dart:typed_data';

enum FriendshipStatus { none, friends, pending, waitingAccept }

abstract class SearchUserEntity {
  final int id;
  final String name;
  final String city;
  final String country;
  final int commonFriends;
  Uint8List imageData;
  FriendshipStatus friendshipStatus;

  SearchUserEntity(
      {required this.id,
      required this.name,
      required this.city,
      required this.country,
      required this.commonFriends,
      required this.imageData,
      required this.friendshipStatus});
}
