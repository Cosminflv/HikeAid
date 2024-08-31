// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CommentDto extends CommentDto {
  @override
  final String? content;
  @override
  final int? postId;
  @override
  final DateTime? timeStamp;
  @override
  final int? userId;

  factory _$CommentDto([void Function(CommentDtoBuilder)? updates]) =>
      (new CommentDtoBuilder()..update(updates))._build();

  _$CommentDto._({this.content, this.postId, this.timeStamp, this.userId})
      : super._();

  @override
  CommentDto rebuild(void Function(CommentDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentDtoBuilder toBuilder() => new CommentDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentDto &&
        content == other.content &&
        postId == other.postId &&
        timeStamp == other.timeStamp &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, timeStamp.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommentDto')
          ..add('content', content)
          ..add('postId', postId)
          ..add('timeStamp', timeStamp)
          ..add('userId', userId))
        .toString();
  }
}

class CommentDtoBuilder implements Builder<CommentDto, CommentDtoBuilder> {
  _$CommentDto? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  int? _postId;
  int? get postId => _$this._postId;
  set postId(int? postId) => _$this._postId = postId;

  DateTime? _timeStamp;
  DateTime? get timeStamp => _$this._timeStamp;
  set timeStamp(DateTime? timeStamp) => _$this._timeStamp = timeStamp;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  CommentDtoBuilder() {
    CommentDto._defaults(this);
  }

  CommentDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _postId = $v.postId;
      _timeStamp = $v.timeStamp;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommentDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CommentDto;
  }

  @override
  void update(void Function(CommentDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommentDto build() => _build();

  _$CommentDto _build() {
    final _$result = _$v ??
        new _$CommentDto._(
            content: content,
            postId: postId,
            timeStamp: timeStamp,
            userId: userId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
