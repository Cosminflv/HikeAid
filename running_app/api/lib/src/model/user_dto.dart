//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/e_gender.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_dto.g.dart';

/// UserDto
///
/// Properties:
/// * [username] 
/// * [firstName] 
/// * [lastName] 
/// * [passwordHash] 
/// * [city] 
/// * [country] 
/// * [weight] 
/// * [eGender] 
/// * [birthdate] 
@BuiltValue()
abstract class UserDto implements Built<UserDto, UserDtoBuilder> {
  @BuiltValueField(wireName: r'username')
  String get username;

  @BuiltValueField(wireName: r'firstName')
  String get firstName;

  @BuiltValueField(wireName: r'lastName')
  String get lastName;

  @BuiltValueField(wireName: r'passwordHash')
  String get passwordHash;

  @BuiltValueField(wireName: r'city')
  String get city;

  @BuiltValueField(wireName: r'country')
  String get country;

  @BuiltValueField(wireName: r'weight')
  int get weight;

  @BuiltValueField(wireName: r'eGender')
  EGender get eGender;
  // enum eGenderEnum {  0,  1,  };

  @BuiltValueField(wireName: r'birthdate')
  DateTime get birthdate;

  UserDto._();

  factory UserDto([void updates(UserDtoBuilder b)]) = _$UserDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserDto> get serializer => _$UserDtoSerializer();
}

class _$UserDtoSerializer implements PrimitiveSerializer<UserDto> {
  @override
  final Iterable<Type> types = const [UserDto, _$UserDto];

  @override
  final String wireName = r'UserDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'username';
    yield serializers.serialize(
      object.username,
      specifiedType: const FullType(String),
    );
    yield r'firstName';
    yield serializers.serialize(
      object.firstName,
      specifiedType: const FullType(String),
    );
    yield r'lastName';
    yield serializers.serialize(
      object.lastName,
      specifiedType: const FullType(String),
    );
    yield r'passwordHash';
    yield serializers.serialize(
      object.passwordHash,
      specifiedType: const FullType(String),
    );
    yield r'city';
    yield serializers.serialize(
      object.city,
      specifiedType: const FullType(String),
    );
    yield r'country';
    yield serializers.serialize(
      object.country,
      specifiedType: const FullType(String),
    );
    yield r'weight';
    yield serializers.serialize(
      object.weight,
      specifiedType: const FullType(int),
    );
    yield r'eGender';
    yield serializers.serialize(
      object.eGender,
      specifiedType: const FullType(EGender),
    );
    yield r'birthdate';
    yield serializers.serialize(
      object.birthdate,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastName = valueDes;
          break;
        case r'passwordHash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.passwordHash = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.city = valueDes;
          break;
        case r'country':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.country = valueDes;
          break;
        case r'weight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.weight = valueDes;
          break;
        case r'eGender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EGender),
          ) as EGender;
          result.eGender = valueDes;
          break;
        case r'birthdate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.birthdate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserDtoBuilder();
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

