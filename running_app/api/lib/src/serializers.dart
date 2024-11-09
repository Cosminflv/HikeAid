//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/comment_dto.dart';
import 'package:openapi/src/model/e_friendship_state.dart';
import 'package:openapi/src/model/e_friendship_status.dart';
import 'package:openapi/src/model/e_gender.dart';
import 'package:openapi/src/model/friendship_model.dart';
import 'package:openapi/src/model/like_dto.dart';
import 'package:openapi/src/model/login_dto.dart';
import 'package:openapi/src/model/search_user_dto.dart';
import 'package:openapi/src/model/social_post_dto.dart';
import 'package:openapi/src/model/social_post_model.dart';
import 'package:openapi/src/model/track_dto.dart';
import 'package:openapi/src/model/update_user_dto.dart';
import 'package:openapi/src/model/user_dto.dart';
import 'package:openapi/src/model/user_model.dart';

part 'serializers.g.dart';

@SerializersFor([
  CommentDto,
  EFriendshipState,
  EFriendshipStatus,
  EGender,
  FriendshipModel,
  LikeDto,
  LoginDto,
  SearchUserDto,
  SocialPostDto,
  SocialPostModel,
  TrackDto,
  UpdateUserDto,
  UserDto,
  UserModel,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(FriendshipModel)]),
        () => ListBuilder<FriendshipModel>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SearchUserDto)]),
        () => ListBuilder<SearchUserDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TrackDto)]),
        () => ListBuilder<TrackDto>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
