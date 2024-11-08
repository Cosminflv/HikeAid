//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/e_friendship_status.dart';
import 'package:openapi/src/model/user_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'friendship_model.g.dart';

/// FriendshipModel
///
/// Properties:
/// * [id] 
/// * [requesterId] 
/// * [receiverId] 
/// * [createdAt] 
/// * [status] 
/// * [requester] 
/// * [receiver] 
@BuiltValue()
abstract class FriendshipModel implements Built<FriendshipModel, FriendshipModelBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'requesterId')
  int? get requesterId;

  @BuiltValueField(wireName: r'receiverId')
  int? get receiverId;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'status')
  EFriendshipStatus? get status;
  // enum statusEnum {  0,  1,  2,  };

  @BuiltValueField(wireName: r'requester')
  UserModel? get requester;

  @BuiltValueField(wireName: r'receiver')
  UserModel? get receiver;

  FriendshipModel._();

  factory FriendshipModel([void updates(FriendshipModelBuilder b)]) = _$FriendshipModel;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FriendshipModelBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FriendshipModel> get serializer => _$FriendshipModelSerializer();
}

class _$FriendshipModelSerializer implements PrimitiveSerializer<FriendshipModel> {
  @override
  final Iterable<Type> types = const [FriendshipModel, _$FriendshipModel];

  @override
  final String wireName = r'FriendshipModel';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FriendshipModel object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.receiverId != null) {
      yield r'receiverId';
      yield serializers.serialize(
        object.receiverId,
        specifiedType: const FullType(int),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(EFriendshipStatus),
      );
    }
    if (object.requester != null) {
      yield r'requester';
      yield serializers.serialize(
        object.requester,
        specifiedType: const FullType(UserModel),
      );
    }
    if (object.receiver != null) {
      yield r'receiver';
      yield serializers.serialize(
        object.receiver,
        specifiedType: const FullType(UserModel),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FriendshipModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FriendshipModelBuilder result,
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
        case r'requesterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requesterId = valueDes;
          break;
        case r'receiverId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.receiverId = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EFriendshipStatus),
          ) as EFriendshipStatus;
          result.status = valueDes;
          break;
        case r'requester':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserModel),
          ) as UserModel;
          result.requester.replace(valueDes);
          break;
        case r'receiver':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserModel),
          ) as UserModel;
          result.receiver.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FriendshipModel deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FriendshipModelBuilder();
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

