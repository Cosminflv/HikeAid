// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TourDto extends TourDto {
  @override
  final int? id;
  @override
  final int? authorId;
  @override
  final String? name;
  @override
  final DateTime? date;
  @override
  final int? distance;
  @override
  final int? duration;
  @override
  final int? totalUp;
  @override
  final int? totalDown;
  @override
  final String? previewImageUrl;
  @override
  final BuiltList<TourCoordinatesDto>? coordinates;

  factory _$TourDto([void Function(TourDtoBuilder)? updates]) =>
      (new TourDtoBuilder()..update(updates))._build();

  _$TourDto._(
      {this.id,
      this.authorId,
      this.name,
      this.date,
      this.distance,
      this.duration,
      this.totalUp,
      this.totalDown,
      this.previewImageUrl,
      this.coordinates})
      : super._();

  @override
  TourDto rebuild(void Function(TourDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TourDtoBuilder toBuilder() => new TourDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TourDto &&
        id == other.id &&
        authorId == other.authorId &&
        name == other.name &&
        date == other.date &&
        distance == other.distance &&
        duration == other.duration &&
        totalUp == other.totalUp &&
        totalDown == other.totalDown &&
        previewImageUrl == other.previewImageUrl &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, authorId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, distance.hashCode);
    _$hash = $jc(_$hash, duration.hashCode);
    _$hash = $jc(_$hash, totalUp.hashCode);
    _$hash = $jc(_$hash, totalDown.hashCode);
    _$hash = $jc(_$hash, previewImageUrl.hashCode);
    _$hash = $jc(_$hash, coordinates.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TourDto')
          ..add('id', id)
          ..add('authorId', authorId)
          ..add('name', name)
          ..add('date', date)
          ..add('distance', distance)
          ..add('duration', duration)
          ..add('totalUp', totalUp)
          ..add('totalDown', totalDown)
          ..add('previewImageUrl', previewImageUrl)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class TourDtoBuilder implements Builder<TourDto, TourDtoBuilder> {
  _$TourDto? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _authorId;
  int? get authorId => _$this._authorId;
  set authorId(int? authorId) => _$this._authorId = authorId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  int? _distance;
  int? get distance => _$this._distance;
  set distance(int? distance) => _$this._distance = distance;

  int? _duration;
  int? get duration => _$this._duration;
  set duration(int? duration) => _$this._duration = duration;

  int? _totalUp;
  int? get totalUp => _$this._totalUp;
  set totalUp(int? totalUp) => _$this._totalUp = totalUp;

  int? _totalDown;
  int? get totalDown => _$this._totalDown;
  set totalDown(int? totalDown) => _$this._totalDown = totalDown;

  String? _previewImageUrl;
  String? get previewImageUrl => _$this._previewImageUrl;
  set previewImageUrl(String? previewImageUrl) =>
      _$this._previewImageUrl = previewImageUrl;

  ListBuilder<TourCoordinatesDto>? _coordinates;
  ListBuilder<TourCoordinatesDto> get coordinates =>
      _$this._coordinates ??= new ListBuilder<TourCoordinatesDto>();
  set coordinates(ListBuilder<TourCoordinatesDto>? coordinates) =>
      _$this._coordinates = coordinates;

  TourDtoBuilder() {
    TourDto._defaults(this);
  }

  TourDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _authorId = $v.authorId;
      _name = $v.name;
      _date = $v.date;
      _distance = $v.distance;
      _duration = $v.duration;
      _totalUp = $v.totalUp;
      _totalDown = $v.totalDown;
      _previewImageUrl = $v.previewImageUrl;
      _coordinates = $v.coordinates?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TourDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TourDto;
  }

  @override
  void update(void Function(TourDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TourDto build() => _build();

  _$TourDto _build() {
    _$TourDto _$result;
    try {
      _$result = _$v ??
          new _$TourDto._(
            id: id,
            authorId: authorId,
            name: name,
            date: date,
            distance: distance,
            duration: duration,
            totalUp: totalUp,
            totalDown: totalDown,
            previewImageUrl: previewImageUrl,
            coordinates: _coordinates?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coordinates';
        _coordinates?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TourDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
