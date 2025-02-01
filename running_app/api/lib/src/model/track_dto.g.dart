// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TrackDto extends TrackDto {
  @override
  final int id;
  @override
  final int userId;
  @override
  final String gpxData;
  @override
  final String logData;

  factory _$TrackDto([void Function(TrackDtoBuilder)? updates]) =>
      (new TrackDtoBuilder()..update(updates))._build();

  _$TrackDto._(
      {required this.id,
      required this.userId,
      required this.gpxData,
      required this.logData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'TrackDto', 'id');
    BuiltValueNullFieldError.checkNotNull(userId, r'TrackDto', 'userId');
    BuiltValueNullFieldError.checkNotNull(gpxData, r'TrackDto', 'gpxData');
    BuiltValueNullFieldError.checkNotNull(logData, r'TrackDto', 'logData');
  }

  @override
  TrackDto rebuild(void Function(TrackDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TrackDtoBuilder toBuilder() => new TrackDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrackDto &&
        id == other.id &&
        userId == other.userId &&
        gpxData == other.gpxData &&
        logData == other.logData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, gpxData.hashCode);
    _$hash = $jc(_$hash, logData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TrackDto')
          ..add('id', id)
          ..add('userId', userId)
          ..add('gpxData', gpxData)
          ..add('logData', logData))
        .toString();
  }
}

class TrackDtoBuilder implements Builder<TrackDto, TrackDtoBuilder> {
  _$TrackDto? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _gpxData;
  String? get gpxData => _$this._gpxData;
  set gpxData(String? gpxData) => _$this._gpxData = gpxData;

  String? _logData;
  String? get logData => _$this._logData;
  set logData(String? logData) => _$this._logData = logData;

  TrackDtoBuilder() {
    TrackDto._defaults(this);
  }

  TrackDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _gpxData = $v.gpxData;
      _logData = $v.logData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TrackDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TrackDto;
  }

  @override
  void update(void Function(TrackDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TrackDto build() => _build();

  _$TrackDto _build() {
    final _$result = _$v ??
        new _$TrackDto._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'TrackDto', 'id'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'TrackDto', 'userId'),
          gpxData: BuiltValueNullFieldError.checkNotNull(
              gpxData, r'TrackDto', 'gpxData'),
          logData: BuiltValueNullFieldError.checkNotNull(
              logData, r'TrackDto', 'logData'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
