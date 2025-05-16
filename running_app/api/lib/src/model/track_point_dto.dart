//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'track_point_dto.g.dart';

/// TrackPointDto
///
/// Properties:
/// * [latitude] 
/// * [longitude] 
/// * [elevation] 
/// * [time] 
@BuiltValue()
abstract class TrackPointDto implements Built<TrackPointDto, TrackPointDtoBuilder> {
  @BuiltValueField(wireName: r'latitude')
  double? get latitude;

  @BuiltValueField(wireName: r'longitude')
  double? get longitude;

  @BuiltValueField(wireName: r'elevation')
  double? get elevation;

  @BuiltValueField(wireName: r'time')
  DateTime? get time;

  TrackPointDto._();

  factory TrackPointDto([void updates(TrackPointDtoBuilder b)]) = _$TrackPointDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TrackPointDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TrackPointDto> get serializer => _$TrackPointDtoSerializer();
}

class _$TrackPointDtoSerializer implements PrimitiveSerializer<TrackPointDto> {
  @override
  final Iterable<Type> types = const [TrackPointDto, _$TrackPointDto];

  @override
  final String wireName = r'TrackPointDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TrackPointDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.latitude != null) {
      yield r'latitude';
      yield serializers.serialize(
        object.latitude,
        specifiedType: const FullType(double),
      );
    }
    if (object.longitude != null) {
      yield r'longitude';
      yield serializers.serialize(
        object.longitude,
        specifiedType: const FullType(double),
      );
    }
    if (object.elevation != null) {
      yield r'elevation';
      yield serializers.serialize(
        object.elevation,
        specifiedType: const FullType(double),
      );
    }
    if (object.time != null) {
      yield r'time';
      yield serializers.serialize(
        object.time,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TrackPointDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TrackPointDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.longitude = valueDes;
          break;
        case r'elevation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.elevation = valueDes;
          break;
        case r'time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.time = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TrackPointDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TrackPointDtoBuilder();
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

