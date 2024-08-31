// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FriendshipModel extends FriendshipModel {
  @override
  final DateTime? createdAt;
  @override
  final int? id;
  @override
  final int? receiverId;
  @override
  final UserModel? reciever;
  @override
  final UserModel? requester;
  @override
  final int? requesterId;
  @override
  final FriendshipStatus? status;

  factory _$FriendshipModel([void Function(FriendshipModelBuilder)? updates]) =>
      (new FriendshipModelBuilder()..update(updates))._build();

  _$FriendshipModel._(
      {this.createdAt,
      this.id,
      this.receiverId,
      this.reciever,
      this.requester,
      this.requesterId,
      this.status})
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
        createdAt == other.createdAt &&
        id == other.id &&
        receiverId == other.receiverId &&
        reciever == other.reciever &&
        requester == other.requester &&
        requesterId == other.requesterId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, reciever.hashCode);
    _$hash = $jc(_$hash, requester.hashCode);
    _$hash = $jc(_$hash, requesterId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendshipModel')
          ..add('createdAt', createdAt)
          ..add('id', id)
          ..add('receiverId', receiverId)
          ..add('reciever', reciever)
          ..add('requester', requester)
          ..add('requesterId', requesterId)
          ..add('status', status))
        .toString();
  }
}

class FriendshipModelBuilder
    implements Builder<FriendshipModel, FriendshipModelBuilder> {
  _$FriendshipModel? _$v;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  UserModelBuilder? _reciever;
  UserModelBuilder get reciever => _$this._reciever ??= new UserModelBuilder();
  set reciever(UserModelBuilder? reciever) => _$this._reciever = reciever;

  UserModelBuilder? _requester;
  UserModelBuilder get requester =>
      _$this._requester ??= new UserModelBuilder();
  set requester(UserModelBuilder? requester) => _$this._requester = requester;

  int? _requesterId;
  int? get requesterId => _$this._requesterId;
  set requesterId(int? requesterId) => _$this._requesterId = requesterId;

  FriendshipStatus? _status;
  FriendshipStatus? get status => _$this._status;
  set status(FriendshipStatus? status) => _$this._status = status;

  FriendshipModelBuilder() {
    FriendshipModel._defaults(this);
  }

  FriendshipModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _id = $v.id;
      _receiverId = $v.receiverId;
      _reciever = $v.reciever?.toBuilder();
      _requester = $v.requester?.toBuilder();
      _requesterId = $v.requesterId;
      _status = $v.status;
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
              createdAt: createdAt,
              id: id,
              receiverId: receiverId,
              reciever: _reciever?.build(),
              requester: _requester?.build(),
              requesterId: requesterId,
              status: status);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reciever';
        _reciever?.build();
        _$failedField = 'requester';
        _requester?.build();
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
