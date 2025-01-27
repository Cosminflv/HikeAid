// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FriendshipDto extends FriendshipDto {
  @override
  final int? id;
  @override
  final int? receiverId;
  @override
  final int? requesterId;
  @override
  final String? requesterName;

  factory _$FriendshipDto([void Function(FriendshipDtoBuilder)? updates]) =>
      (new FriendshipDtoBuilder()..update(updates))._build();

  _$FriendshipDto._(
      {this.id, this.receiverId, this.requesterId, this.requesterName})
      : super._();

  @override
  FriendshipDto rebuild(void Function(FriendshipDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendshipDtoBuilder toBuilder() => new FriendshipDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendshipDto &&
        id == other.id &&
        receiverId == other.receiverId &&
        requesterId == other.requesterId &&
        requesterName == other.requesterName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, requesterId.hashCode);
    _$hash = $jc(_$hash, requesterName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendshipDto')
          ..add('id', id)
          ..add('receiverId', receiverId)
          ..add('requesterId', requesterId)
          ..add('requesterName', requesterName))
        .toString();
  }
}

class FriendshipDtoBuilder
    implements Builder<FriendshipDto, FriendshipDtoBuilder> {
  _$FriendshipDto? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  int? _requesterId;
  int? get requesterId => _$this._requesterId;
  set requesterId(int? requesterId) => _$this._requesterId = requesterId;

  String? _requesterName;
  String? get requesterName => _$this._requesterName;
  set requesterName(String? requesterName) =>
      _$this._requesterName = requesterName;

  FriendshipDtoBuilder() {
    FriendshipDto._defaults(this);
  }

  FriendshipDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _receiverId = $v.receiverId;
      _requesterId = $v.requesterId;
      _requesterName = $v.requesterName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendshipDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FriendshipDto;
  }

  @override
  void update(void Function(FriendshipDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FriendshipDto build() => _build();

  _$FriendshipDto _build() {
    final _$result = _$v ??
        new _$FriendshipDto._(
          id: id,
          receiverId: receiverId,
          requesterId: requesterId,
          requesterName: requesterName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
