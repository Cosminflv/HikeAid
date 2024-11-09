//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/e_friendship_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_user_dto.g.dart';

/// SearchUserDto
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [city] 
/// * [country] 
/// * [commonFriends] 
/// * [friendshipStatus] 
/// * [imageData] 
@BuiltValue()
abstract class SearchUserDto implements Built<SearchUserDto, SearchUserDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'country')
  String? get country;

  @BuiltValueField(wireName: r'commonFriends')
  int? get commonFriends;

  @BuiltValueField(wireName: r'friendshipStatus')
  EFriendshipStatus? get friendshipStatus;
  // enum friendshipStatusEnum {  0,  1,  2,  };

  @BuiltValueField(wireName: r'imageData')
  String? get imageData;

  SearchUserDto._();

  factory SearchUserDto([void updates(SearchUserDtoBuilder b)]) = _$SearchUserDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchUserDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchUserDto> get serializer => _$SearchUserDtoSerializer();
}

class _$SearchUserDtoSerializer implements PrimitiveSerializer<SearchUserDto> {
  @override
  final Iterable<Type> types = const [SearchUserDto, _$SearchUserDto];

  @override
  final String wireName = r'SearchUserDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchUserDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.country != null) {
      yield r'country';
      yield serializers.serialize(
        object.country,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.commonFriends != null) {
      yield r'commonFriends';
      yield serializers.serialize(
        object.commonFriends,
        specifiedType: const FullType(int),
      );
    }
    if (object.friendshipStatus != null) {
      yield r'friendshipStatus';
      yield serializers.serialize(
        object.friendshipStatus,
        specifiedType: const FullType(EFriendshipStatus),
      );
    }
    if (object.imageData != null) {
      yield r'imageData';
      yield serializers.serialize(
        object.imageData,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchUserDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SearchUserDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'country':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.country = valueDes;
          break;
        case r'commonFriends':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.commonFriends = valueDes;
          break;
        case r'friendshipStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EFriendshipStatus),
          ) as EFriendshipStatus;
          result.friendshipStatus = valueDes;
          break;
        case r'imageData':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.imageData = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchUserDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchUserDtoBuilder();
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

