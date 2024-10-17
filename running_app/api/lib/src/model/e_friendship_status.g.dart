// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_friendship_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EFriendshipStatus _$number0 = const EFriendshipStatus._('number0');
const EFriendshipStatus _$number1 = const EFriendshipStatus._('number1');
const EFriendshipStatus _$number2 = const EFriendshipStatus._('number2');

EFriendshipStatus _$valueOf(String name) {
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

final BuiltSet<EFriendshipStatus> _$values =
    new BuiltSet<EFriendshipStatus>(const <EFriendshipStatus>[
  _$number0,
  _$number1,
  _$number2,
]);

class _$EFriendshipStatusMeta {
  const _$EFriendshipStatusMeta();
  EFriendshipStatus get number0 => _$number0;
  EFriendshipStatus get number1 => _$number1;
  EFriendshipStatus get number2 => _$number2;
  EFriendshipStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<EFriendshipStatus> get values => _$values;
}

abstract class _$EFriendshipStatusMixin {
  // ignore: non_constant_identifier_names
  _$EFriendshipStatusMeta get EFriendshipStatus =>
      const _$EFriendshipStatusMeta();
}

Serializer<EFriendshipStatus> _$eFriendshipStatusSerializer =
    new _$EFriendshipStatusSerializer();

class _$EFriendshipStatusSerializer
    implements PrimitiveSerializer<EFriendshipStatus> {
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
  final Iterable<Type> types = const <Type>[EFriendshipStatus];
  @override
  final String wireName = 'EFriendshipStatus';

  @override
  Object serialize(Serializers serializers, EFriendshipStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EFriendshipStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EFriendshipStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
