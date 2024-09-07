// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FriendshipModel extends FriendshipModel {
  @override
  final int? id;
  @override
  final int? requesterId;
  @override
  final int? receiverId;
  @override
  final DateTime? createdAt;
  @override
  final FriendshipStatus? status;
  @override
  final UserModel? requester;
  @override
  final UserModel? reciever;

  factory _$FriendshipModel([void Function(FriendshipModelBuilder)? updates]) =>
      (new FriendshipModelBuilder()..update(updates))._build();

  _$FriendshipModel._(
      {this.id,
      this.requesterId,
      this.receiverId,
      this.createdAt,
      this.status,
      this.requester,
      this.reciever})
      : super._();

  @override
  FriendshipModel rebuild(void Function(FriendshipModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendshipModelBuilder toBuilder() =>
      new FriendshipModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendshipModel &&
        id == other.id &&
        requesterId == other.requesterId &&
        receiverId == other.receiverId &&
        createdAt == other.createdAt &&
        status == other.status &&
        requester == other.requester &&
        reciever == other.reciever;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, requesterId.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, requester.hashCode);
    _$hash = $jc(_$hash, reciever.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendshipModel')
          ..add('id', id)
          ..add('requesterId', requesterId)
          ..add('receiverId', receiverId)
          ..add('createdAt', createdAt)
          ..add('status', status)
          ..add('requester', requester)
          ..add('reciever', reciever))
        .toString();
  }
}

class FriendshipModelBuilder
    implements Builder<FriendshipModel, FriendshipModelBuilder> {
  _$FriendshipModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _requesterId;
  int? get requesterId => _$this._requesterId;
  set requesterId(int? requesterId) => _$this._requesterId = requesterId;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  FriendshipStatus? _status;
  FriendshipStatus? get status => _$this._status;
  set status(FriendshipStatus? status) => _$this._status = status;

  UserModelBuilder? _requester;
  UserModelBuilder get requester =>
      _$this._requester ??= new UserModelBuilder();
  set requester(UserModelBuilder? requester) => _$this._requester = requester;

  UserModelBuilder? _reciever;
  UserModelBuilder get reciever => _$this._reciever ??= new UserModelBuilder();
  set reciever(UserModelBuilder? reciever) => _$this._reciever = reciever;

  FriendshipModelBuilder() {
    FriendshipModel._defaults(this);
  }

  FriendshipModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _requesterId = $v.requesterId;
      _receiverId = $v.receiverId;
      _createdAt = $v.createdAt;
      _status = $v.status;
      _requester = $v.requester?.toBuilder();
      _reciever = $v.reciever?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendshipModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FriendshipModel;
  }

  @override
  void update(void Function(FriendshipModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FriendshipModel build() => _build();

  _$FriendshipModel _build() {
    _$FriendshipModel _$result;
    try {
      _$result = _$v ??
          new _$FriendshipModel._(
              id: id,
              requesterId: requesterId,
              receiverId: receiverId,
              createdAt: createdAt,
              status: status,
              requester: _requester?.build(),
              reciever: _reciever?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'requester';
        _requester?.build();
        _$failedField = 'reciever';
        _reciever?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FriendshipModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
