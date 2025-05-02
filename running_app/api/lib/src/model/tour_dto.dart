//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/tour_coordinates_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tour_dto.g.dart';

/// TourDto
///
/// Properties:
/// * [id] 
/// * [authorId] 
/// * [name] 
/// * [date] 
/// * [distance] 
/// * [duration] 
/// * [totalUp] 
/// * [totalDown] 
/// * [previewImageUrl] 
/// * [coordinates] 
@BuiltValue()
abstract class TourDto implements Built<TourDto, TourDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'authorId')
  int? get authorId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'date')
  DateTime? get date;

  @BuiltValueField(wireName: r'distance')
  int? get distance;

  @BuiltValueField(wireName: r'duration')
  int? get duration;

  @BuiltValueField(wireName: r'totalUp')
  int? get totalUp;

  @BuiltValueField(wireName: r'totalDown')
  int? get totalDown;

  @BuiltValueField(wireName: r'previewImageUrl')
  String? get previewImageUrl;

  @BuiltValueField(wireName: r'coordinates')
  BuiltList<TourCoordinatesDto>? get coordinates;

  TourDto._();

  factory TourDto([void updates(TourDtoBuilder b)]) = _$TourDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TourDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TourDto> get serializer => _$TourDtoSerializer();
}

class _$TourDtoSerializer implements PrimitiveSerializer<TourDto> {
  @override
  final Iterable<Type> types = const [TourDto, _$TourDto];

  @override
  final String wireName = r'TourDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TourDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.authorId != null) {
      yield r'authorId';
      yield serializers.serialize(
        object.authorId,
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
    if (object.date != null) {
      yield r'date';
      yield serializers.serialize(
        object.date,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.distance != null) {
      yield r'distance';
      yield serializers.serialize(
        object.distance,
        specifiedType: const FullType(int),
      );
    }
    if (object.duration != null) {
      yield r'duration';
      yield serializers.serialize(
        object.duration,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalUp != null) {
      yield r'totalUp';
      yield serializers.serialize(
        object.totalUp,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalDown != null) {
      yield r'totalDown';
      yield serializers.serialize(
        object.totalDown,
        specifiedType: const FullType(int),
      );
    }
    if (object.previewImageUrl != null) {
      yield r'previewImageUrl';
      yield serializers.serialize(
        object.previewImageUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.coordinates != null) {
      yield r'coordinates';
      yield serializers.serialize(
        object.coordinates,
        specifiedType: const FullType.nullable(BuiltList, [FullType(TourCoordinatesDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TourDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TourDtoBuilder result,
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
        case r'authorId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.authorId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.date = valueDes;
          break;
        case r'distance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.distance = valueDes;
          break;
        case r'duration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.duration = valueDes;
          break;
        case r'totalUp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalUp = valueDes;
          break;
        case r'totalDown':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalDown = valueDes;
          break;
        case r'previewImageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.previewImageUrl = valueDes;
          break;
        case r'coordinates':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(TourCoordinatesDto)]),
          ) as BuiltList<TourCoordinatesDto>?;
          if (valueDes == null) continue;
          result.coordinates.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TourDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TourDtoBuilder();
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

