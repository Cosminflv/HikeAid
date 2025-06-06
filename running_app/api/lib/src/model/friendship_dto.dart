//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'friendship_dto.g.dart';

/// FriendshipDto
///
/// Properties:
/// * [id] 
/// * [receiverId] 
/// * [requesterId] 
/// * [requesterName] 
@BuiltValue()
abstract class FriendshipDto implements Built<FriendshipDto, FriendshipDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'receiverId')
  int? get receiverId;

  @BuiltValueField(wireName: r'requesterId')
  int? get requesterId;

  @BuiltValueField(wireName: r'requesterName')
  String? get requesterName;

  FriendshipDto._();

  factory FriendshipDto([void updates(FriendshipDtoBuilder b)]) = _$FriendshipDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FriendshipDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FriendshipDto> get serializer => _$FriendshipDtoSerializer();
}

class _$FriendshipDtoSerializer implements PrimitiveSerializer<FriendshipDto> {
  @override
  final Iterable<Type> types = const [FriendshipDto, _$FriendshipDto];

  @override
  final String wireName = r'FriendshipDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FriendshipDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.receiverId != null) {
      yield r'receiverId';
      yield serializers.serialize(
        object.receiverId,
        specifiedType: const FullType(int),
      );
    }
    if (object.requesterId != null) {
      yield r'requesterId';
      yield serializers.serialize(
        object.requesterId,
        specifiedType: const FullType(int),
      );
    }
    if (object.requesterName != null) {
      yield r'requesterName';
      yield serializers.serialize(
        object.requesterName,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FriendshipDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FriendshipDtoBuilder result,
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
        case r'receiverId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.receiverId = valueDes;
          break;
        case r'requesterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requesterId = valueDes;
          break;
        case r'requesterName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.requesterName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FriendshipDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FriendshipDtoBuilder();
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

