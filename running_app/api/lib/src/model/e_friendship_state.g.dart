// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_friendship_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EFriendshipState _$number0 = const EFriendshipState._('number0');
const EFriendshipState _$number1 = const EFriendshipState._('number1');
const EFriendshipState _$number2 = const EFriendshipState._('number2');

EFriendshipState _$valueOf(String name) {
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

final BuiltSet<EFriendshipState> _$values =
    new BuiltSet<EFriendshipState>(const <EFriendshipState>[
  _$number0,
  _$number1,
  _$number2,
]);

class _$EFriendshipStateMeta {
  const _$EFriendshipStateMeta();
  EFriendshipState get number0 => _$number0;
  EFriendshipState get number1 => _$number1;
  EFriendshipState get number2 => _$number2;
  EFriendshipState valueOf(String name) => _$valueOf(name);
  BuiltSet<EFriendshipState> get values => _$values;
}

abstract class _$EFriendshipStateMixin {
  // ignore: non_constant_identifier_names
  _$EFriendshipStateMeta get EFriendshipState => const _$EFriendshipStateMeta();
}

Serializer<EFriendshipState> _$eFriendshipStateSerializer =
    new _$EFriendshipStateSerializer();

class _$EFriendshipStateSerializer
    implements PrimitiveSerializer<EFriendshipState> {
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
  final Iterable<Type> types = const <Type>[EFriendshipState];
  @override
  final String wireName = 'EFriendshipState';

  @override
  Object serialize(Serializers serializers, EFriendshipState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EFriendshipState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EFriendshipState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
