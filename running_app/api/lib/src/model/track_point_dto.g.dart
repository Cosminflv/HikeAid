// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_point_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TrackPointDto extends TrackPointDto {
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? elevation;
  @override
  final DateTime? time;

  factory _$TrackPointDto([void Function(TrackPointDtoBuilder)? updates]) =>
      (new TrackPointDtoBuilder()..update(updates))._build();

  _$TrackPointDto._({this.latitude, this.longitude, this.elevation, this.time})
      : super._();

  @override
  TrackPointDto rebuild(void Function(TrackPointDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TrackPointDtoBuilder toBuilder() => new TrackPointDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrackPointDto &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        elevation == other.elevation &&
        time == other.time;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, elevation.hashCode);
    _$hash = $jc(_$hash, time.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TrackPointDto')
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('elevation', elevation)
          ..add('time', time))
        .toString();
  }
}

class TrackPointDtoBuilder
    implements Builder<TrackPointDto, TrackPointDtoBuilder> {
  _$TrackPointDto? _$v;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  double? _elevation;
  double? get elevation => _$this._elevation;
  set elevation(double? elevation) => _$this._elevation = elevation;

  DateTime? _time;
  DateTime? get time => _$this._time;
  set time(DateTime? time) => _$this._time = time;

  TrackPointDtoBuilder() {
    TrackPointDto._defaults(this);
  }

  TrackPointDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _elevation = $v.elevation;
      _time = $v.time;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TrackPointDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TrackPointDto;
  }

  @override
  void update(void Function(TrackPointDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TrackPointDto build() => _build();

  _$TrackPointDto _build() {
    final _$result = _$v ??
        new _$TrackPointDto._(
          latitude: latitude,
          longitude: longitude,
          elevation: elevation,
          time: time,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
