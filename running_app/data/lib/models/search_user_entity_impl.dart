import 'dart:convert';

import 'package:data/utils/converters.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:openapi/openapi.dart';

class SearchUserEntityImpl extends SearchUserEntity {
  SearchUserEntityImpl(
      {required super.id,
      required super.name,
      required super.city,
      required super.country,
      required super.commonFriends,
      required super.imageData,
      required super.friendshipStatus});

  // Factory constructor for creating an instance from DTO
  factory SearchUserEntityImpl.fromDto(SearchUserDto dto) {
    final image = base64Decode(dto.imageData!);
    return SearchUserEntityImpl(
        id: dto.id!,
        name: dto.name!,
        city: dto.city!,
        country: dto.country!,
        commonFriends: dto.commonFriends!,
        imageData: image,
        friendshipStatus: convertToFriendshipStatus(dto.friendshipStatus!));
  }
}
