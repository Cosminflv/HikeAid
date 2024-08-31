// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FriendshipStatus _$number0 = const FriendshipStatus._('number0');
const FriendshipStatus _$number1 = const FriendshipStatus._('number1');
const FriendshipStatus _$number2 = const FriendshipStatus._('number2');

FriendshipStatus _$valueOf(String name) {
  switch (name) {
    case 'number0':
      return _$number0;
    case 'number1':
      return _$number1;
    case 'number2':
      return _$number2;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<FriendshipStatus> _$values =
    new BuiltSet<FriendshipStatus>(const <FriendshipStatus>[
  _$number0,
  _$number1,
  _$number2,
]);

class _$FriendshipStatusMeta {
  const _$FriendshipStatusMeta();
  FriendshipStatus get number0 => _$number0;
  FriendshipStatus get number1 => _$number1;
  FriendshipStatus get number2 => _$number2;
  FriendshipStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<FriendshipStatus> get values => _$values;
}

abstract class _$FriendshipStatusMixin {
  // ignore: non_constant_identifier_names
  _$FriendshipStatusMeta get FriendshipStatus => const _$FriendshipStatusMeta();
}

Serializer<FriendshipStatus> _$friendshipStatusSerializer =
    new _$FriendshipStatusSerializer();

class _$FriendshipStatusSerializer
    implements PrimitiveSerializer<FriendshipStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number0': 0,
    'number1': 1,
    'number2': 2,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    0: 'number0',
    1: 'number1',
    2: 'number2',
  };

  @override
  final Iterable<Type> types = const <Type>[FriendshipStatus];
  @override
  final String wireName = 'FriendshipStatus';

  @override
  Object serialize(Serializers serializers, FriendshipStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FriendshipStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FriendshipStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
