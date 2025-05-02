//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tour_coordinates_dto.g.dart';

/// TourCoordinatesDto
///
/// Properties:
/// * [latitude] 
/// * [longitude] 
/// * [speed] 
/// * [altitude] 
/// * [timestamp] 
@BuiltValue()
abstract class TourCoordinatesDto implements Built<TourCoordinatesDto, TourCoordinatesDtoBuilder> {
  @BuiltValueField(wireName: r'latitude')
  double? get latitude;

  @BuiltValueField(wireName: r'longitude')
  double? get longitude;

  @BuiltValueField(wireName: r'speed')
  double? get speed;

  @BuiltValueField(wireName: r'altitude')
  int? get altitude;

  @BuiltValueField(wireName: r'timestamp')
  DateTime? get timestamp;

  TourCoordinatesDto._();

  factory TourCoordinatesDto([void updates(TourCoordinatesDtoBuilder b)]) = _$TourCoordinatesDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TourCoordinatesDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TourCoordinatesDto> get serializer => _$TourCoordinatesDtoSerializer();
}

class _$TourCoordinatesDtoSerializer implements PrimitiveSerializer<TourCoordinatesDto> {
  @override
  final Iterable<Type> types = const [TourCoordinatesDto, _$TourCoordinatesDto];

  @override
  final String wireName = r'TourCoordinatesDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TourCoordinatesDto object, {
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
    if (object.speed != null) {
      yield r'speed';
      yield serializers.serialize(
        object.speed,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.altitude != null) {
      yield r'altitude';
      yield serializers.serialize(
        object.altitude,
        specifiedType: const FullType(int),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TourCoordinatesDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TourCoordinatesDtoBuilder result,
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
        case r'speed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.speed = valueDes;
          break;
        case r'altitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.altitude = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TourCoordinatesDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TourCoordinatesDtoBuilder();
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

