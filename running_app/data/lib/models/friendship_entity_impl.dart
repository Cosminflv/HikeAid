import 'package:domain/entities/friendship_entity.dart';
import 'package:openapi/openapi.dart';

class FriendshipEntityImpl extends FriendshipEntity {
  FriendshipEntityImpl({
    required super.id,
    required super.requesterId,
    required super.receiverId,
    required super.requesterName,
  });

  factory FriendshipEntityImpl.fromDto(FriendshipDto dto) {
    return FriendshipEntityImpl(
      id: dto.id!,
      receiverId: dto.receiverId!,
      requesterId: dto.requesterId!,
      requesterName: dto.requesterName!,
    );
  }
}
