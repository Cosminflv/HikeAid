// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TrackDto extends TrackDto {
  @override
  final String? gpxData;
  @override
  final int? id;
  @override
  final String? logData;
  @override
  final int? userId;

  factory _$TrackDto([void Function(TrackDtoBuilder)? updates]) =>
      (new TrackDtoBuilder()..update(updates))._build();

  _$TrackDto._({this.gpxData, this.id, this.logData, this.userId}) : super._();

  @override
  TrackDto rebuild(void Function(TrackDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TrackDtoBuilder toBuilder() => new TrackDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrackDto &&
        gpxData == other.gpxData &&
        id == other.id &&
        logData == other.logData &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, gpxData.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, logData.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TrackDto')
          ..add('gpxData', gpxData)
          ..add('id', id)
          ..add('logData', logData)
          ..add('userId', userId))
        .toString();
  }
}

class TrackDtoBuilder implements Builder<TrackDto, TrackDtoBuilder> {
  _$TrackDto? _$v;

  String? _gpxData;
  String? get gpxData => _$this._gpxData;
  set gpxData(String? gpxData) => _$this._gpxData = gpxData;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _logData;
  String? get logData => _$this._logData;
  set logData(String? logData) => _$this._logData = logData;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  TrackDtoBuilder() {
    TrackDto._defaults(this);
  }

  TrackDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _gpxData = $v.gpxData;
      _id = $v.id;
      _logData = $v.logData;
      _userId = $v.userId;
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
            gpxData: gpxData, id: id, logData: logData, userId: userId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
