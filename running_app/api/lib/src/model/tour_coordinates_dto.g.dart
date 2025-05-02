// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_coordinates_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TourCoordinatesDto extends TourCoordinatesDto {
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? speed;
  @override
  final int? altitude;
  @override
  final DateTime? timestamp;

  factory _$TourCoordinatesDto(
          [void Function(TourCoordinatesDtoBuilder)? updates]) =>
      (new TourCoordinatesDtoBuilder()..update(updates))._build();

  _$TourCoordinatesDto._(
      {this.latitude,
      this.longitude,
      this.speed,
      this.altitude,
      this.timestamp})
      : super._();

  @override
  TourCoordinatesDto rebuild(
          void Function(TourCoordinatesDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TourCoordinatesDtoBuilder toBuilder() =>
      new TourCoordinatesDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TourCoordinatesDto &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        speed == other.speed &&
        altitude == other.altitude &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, speed.hashCode);
    _$hash = $jc(_$hash, altitude.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TourCoordinatesDto')
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('speed', speed)
          ..add('altitude', altitude)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class TourCoordinatesDtoBuilder
    implements Builder<TourCoordinatesDto, TourCoordinatesDtoBuilder> {
  _$TourCoordinatesDto? _$v;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  double? _speed;
  double? get speed => _$this._speed;
  set speed(double? speed) => _$this._speed = speed;

  int? _altitude;
  int? get altitude => _$this._altitude;
  set altitude(int? altitude) => _$this._altitude = altitude;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  TourCoordinatesDtoBuilder() {
    TourCoordinatesDto._defaults(this);
  }

  TourCoordinatesDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _speed = $v.speed;
      _altitude = $v.altitude;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TourCoordinatesDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TourCoordinatesDto;
  }

  @override
  void update(void Function(TourCoordinatesDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TourCoordinatesDto build() => _build();

  _$TourCoordinatesDto _build() {
    final _$result = _$v ??
        new _$TourCoordinatesDto._(
          latitude: latitude,
          longitude: longitude,
          speed: speed,
          altitude: altitude,
          timestamp: timestamp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
