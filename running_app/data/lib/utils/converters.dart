import 'package:domain/entities/search_user_entity.dart';
import 'package:openapi/openapi.dart';

FriendshipStatus convertToFriendshipStatus(EFriendshipStatus value) {
  switch (value) {
    case EFriendshipStatus.number0:
      return FriendshipStatus.none;
    case EFriendshipStatus.number1:
      return FriendshipStatus.friends;
    case EFriendshipStatus.number2:
      return FriendshipStatus.pending;
    default:
      return FriendshipStatus.none;
  }
}
