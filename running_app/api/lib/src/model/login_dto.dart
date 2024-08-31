//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_dto.g.dart';

/// LoginDto
///
/// Properties:
/// * [password] 
/// * [username] 
@BuiltValue()
abstract class LoginDto implements Built<LoginDto, LoginDtoBuilder> {
  @BuiltValueField(wireName: r'password')
  String? get password;

  @BuiltValueField(wireName: r'username')
  String? get username;

  LoginDto._();

  factory LoginDto([void updates(LoginDtoBuilder b)]) = _$LoginDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginDto> get serializer => _$LoginDtoSerializer();
}

class _$LoginDtoSerializer implements PrimitiveSerializer<LoginDto> {
  @override
  final Iterable<Type> types = const [LoginDto, _$LoginDto];

  @override
  final String wireName = r'LoginDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.username != null) {
      yield r'username';
      yield serializers.serialize(
        object.username,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.password = valueDes;
          break;
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.username = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

