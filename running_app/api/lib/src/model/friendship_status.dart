//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'friendship_status.g.dart';

class FriendshipStatus extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 0)
  static const FriendshipStatus number0 = _$number0;
  @BuiltValueEnumConst(wireNumber: 1)
  static const FriendshipStatus number1 = _$number1;
  @BuiltValueEnumConst(wireNumber: 2)
  static const FriendshipStatus number2 = _$number2;

  static Serializer<FriendshipStatus> get serializer => _$friendshipStatusSerializer;

  const FriendshipStatus._(String name): super(name);

  static BuiltSet<FriendshipStatus> get values => _$values;
  static FriendshipStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FriendshipStatusMixin = Object with _$FriendshipStatusMixin;

