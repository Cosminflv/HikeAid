// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CoordinatesDto extends CoordinatesDto {
  @override
  final double? latitude;
  @override
  final double? longitude;

  factory _$CoordinatesDto([void Function(CoordinatesDtoBuilder)? updates]) =>
      (new CoordinatesDtoBuilder()..update(updates))._build();

  _$CoordinatesDto._({this.latitude, this.longitude}) : super._();

  @override
  CoordinatesDto rebuild(void Function(CoordinatesDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CoordinatesDtoBuilder toBuilder() =>
      new CoordinatesDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CoordinatesDto &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CoordinatesDto')
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class CoordinatesDtoBuilder
    implements Builder<CoordinatesDto, CoordinatesDtoBuilder> {
  _$CoordinatesDto? _$v;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  CoordinatesDtoBuilder() {
    CoordinatesDto._defaults(this);
  }

  CoordinatesDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CoordinatesDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CoordinatesDto;
  }

  @override
  void update(void Function(CoordinatesDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CoordinatesDto build() => _build();

  _$CoordinatesDto _build() {
    final _$result = _$v ??
        new _$CoordinatesDto._(
          latitude: latitude,
          longitude: longitude,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
