//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coordinates_dto.g.dart';

/// CoordinatesDto
///
/// Properties:
/// * [latitude] 
/// * [longitude] 
@BuiltValue()
abstract class CoordinatesDto implements Built<CoordinatesDto, CoordinatesDtoBuilder> {
  @BuiltValueField(wireName: r'latitude')
  double? get latitude;

  @BuiltValueField(wireName: r'longitude')
  double? get longitude;

  CoordinatesDto._();

  factory CoordinatesDto([void updates(CoordinatesDtoBuilder b)]) = _$CoordinatesDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CoordinatesDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CoordinatesDto> get serializer => _$CoordinatesDtoSerializer();
}

class _$CoordinatesDtoSerializer implements PrimitiveSerializer<CoordinatesDto> {
  @override
  final Iterable<Type> types = const [CoordinatesDto, _$CoordinatesDto];

  @override
  final String wireName = r'CoordinatesDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CoordinatesDto object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CoordinatesDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CoordinatesDtoBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CoordinatesDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CoordinatesDtoBuilder();
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

