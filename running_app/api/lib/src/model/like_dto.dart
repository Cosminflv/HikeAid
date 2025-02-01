//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'like_dto.g.dart';

/// LikeDto
///
/// Properties:
/// * [postId] 
/// * [userId] 
@BuiltValue()
abstract class LikeDto implements Built<LikeDto, LikeDtoBuilder> {
  @BuiltValueField(wireName: r'postId')
  int get postId;

  @BuiltValueField(wireName: r'userId')
  int get userId;

  LikeDto._();

  factory LikeDto([void updates(LikeDtoBuilder b)]) = _$LikeDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LikeDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LikeDto> get serializer => _$LikeDtoSerializer();
}

class _$LikeDtoSerializer implements PrimitiveSerializer<LikeDto> {
  @override
  final Iterable<Type> types = const [LikeDto, _$LikeDto];

  @override
  final String wireName = r'LikeDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LikeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'postId';
    yield serializers.serialize(
      object.postId,
      specifiedType: const FullType(int),
    );
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LikeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LikeDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'postId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.postId = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LikeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LikeDtoBuilder();
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

