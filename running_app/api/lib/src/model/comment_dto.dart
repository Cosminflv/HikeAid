//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'comment_dto.g.dart';

/// CommentDto
///
/// Properties:
/// * [postId] 
/// * [userId] 
/// * [content] 
/// * [timeStamp] 
@BuiltValue()
abstract class CommentDto implements Built<CommentDto, CommentDtoBuilder> {
  @BuiltValueField(wireName: r'postId')
  int? get postId;

  @BuiltValueField(wireName: r'userId')
  int? get userId;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'timeStamp')
  DateTime? get timeStamp;

  CommentDto._();

  factory CommentDto([void updates(CommentDtoBuilder b)]) = _$CommentDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CommentDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CommentDto> get serializer => _$CommentDtoSerializer();
}

class _$CommentDtoSerializer implements PrimitiveSerializer<CommentDto> {
  @override
  final Iterable<Type> types = const [CommentDto, _$CommentDto];

  @override
  final String wireName = r'CommentDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CommentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.postId != null) {
      yield r'postId';
      yield serializers.serialize(
        object.postId,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.timeStamp != null) {
      yield r'timeStamp';
      yield serializers.serialize(
        object.timeStamp,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CommentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CommentDtoBuilder result,
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
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.content = valueDes;
          break;
        case r'timeStamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timeStamp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CommentDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CommentDtoBuilder();
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

