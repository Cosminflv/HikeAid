// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_gender.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EGender _$number0 = const EGender._('number0');
const EGender _$number1 = const EGender._('number1');

EGender _$valueOf(String name) {
  switch (name) {
    case 'number0':
      return _$number0;
    case 'number1':
      return _$number1;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EGender> _$values = new BuiltSet<EGender>(const <EGender>[
  _$number0,
  _$number1,
]);

class _$EGenderMeta {
  const _$EGenderMeta();
  EGender get number0 => _$number0;
  EGender get number1 => _$number1;
  EGender valueOf(String name) => _$valueOf(name);
  BuiltSet<EGender> get values => _$values;
}

abstract class _$EGenderMixin {
  // ignore: non_constant_identifier_names
  _$EGenderMeta get EGender => const _$EGenderMeta();
}

Serializer<EGender> _$eGenderSerializer = new _$EGenderSerializer();

class _$EGenderSerializer implements PrimitiveSerializer<EGender> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number0': 0,
    'number1': 1,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    0: 'number0',
    1: 'number1',
  };

  @override
  final Iterable<Type> types = const <Type>[EGender];
  @override
  final String wireName = 'EGender';

  @override
  Object serialize(Serializers serializers, EGender object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EGender deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EGender.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
