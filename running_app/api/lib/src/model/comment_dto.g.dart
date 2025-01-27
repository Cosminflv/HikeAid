// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CommentDto extends CommentDto {
  @override
  final int? postId;
  @override
  final int? userId;
  @override
  final String? content;
  @override
  final DateTime? timeStamp;

  factory _$CommentDto([void Function(CommentDtoBuilder)? updates]) =>
      (new CommentDtoBuilder()..update(updates))._build();

  _$CommentDto._({this.postId, this.userId, this.content, this.timeStamp})
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
        postId == other.postId &&
        userId == other.userId &&
        content == other.content &&
        timeStamp == other.timeStamp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, timeStamp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommentDto')
          ..add('postId', postId)
          ..add('userId', userId)
          ..add('content', content)
          ..add('timeStamp', timeStamp))
        .toString();
  }
}

class CommentDtoBuilder implements Builder<CommentDto, CommentDtoBuilder> {
  _$CommentDto? _$v;

  int? _postId;
  int? get postId => _$this._postId;
  set postId(int? postId) => _$this._postId = postId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DateTime? _timeStamp;
  DateTime? get timeStamp => _$this._timeStamp;
  set timeStamp(DateTime? timeStamp) => _$this._timeStamp = timeStamp;

  CommentDtoBuilder() {
    CommentDto._defaults(this);
  }

  CommentDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postId = $v.postId;
      _userId = $v.userId;
      _content = $v.content;
      _timeStamp = $v.timeStamp;
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
          postId: postId,
          userId: userId,
          content: content,
          timeStamp: timeStamp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
