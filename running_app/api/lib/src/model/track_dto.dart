//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'track_dto.g.dart';

/// TrackDto
///
/// Properties:
/// * [gpxData] 
/// * [id] 
/// * [logData] 
/// * [userId] 
@BuiltValue()
abstract class TrackDto implements Built<TrackDto, TrackDtoBuilder> {
  @BuiltValueField(wireName: r'gpxData')
  String? get gpxData;

  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'logData')
  String? get logData;

  @BuiltValueField(wireName: r'userId')
  int? get userId;

  TrackDto._();

  factory TrackDto([void updates(TrackDtoBuilder b)]) = _$TrackDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TrackDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TrackDto> get serializer => _$TrackDtoSerializer();
}

class _$TrackDtoSerializer implements PrimitiveSerializer<TrackDto> {
  @override
  final Iterable<Type> types = const [TrackDto, _$TrackDto];

  @override
  final String wireName = r'TrackDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TrackDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.gpxData != null) {
      yield r'gpxData';
      yield serializers.serialize(
        object.gpxData,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.logData != null) {
      yield r'logData';
      yield serializers.serialize(
        object.logData,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TrackDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TrackDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'gpxData':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.gpxData = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'logData':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.logData = valueDes;
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
  TrackDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TrackDtoBuilder();
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

