// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SearchUserDto extends SearchUserDto {
  @override
  final int id;
  @override
  final String name;
  @override
  final String city;
  @override
  final String country;
  @override
  final int commonFriends;
  @override
  final EFriendshipStatus friendshipStatus;

  factory _$SearchUserDto([void Function(SearchUserDtoBuilder)? updates]) =>
      (new SearchUserDtoBuilder()..update(updates))._build();

  _$SearchUserDto._(
      {required this.id,
      required this.name,
      required this.city,
      required this.country,
      required this.commonFriends,
      required this.friendshipStatus})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'SearchUserDto', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'SearchUserDto', 'name');
    BuiltValueNullFieldError.checkNotNull(city, r'SearchUserDto', 'city');
    BuiltValueNullFieldError.checkNotNull(country, r'SearchUserDto', 'country');
    BuiltValueNullFieldError.checkNotNull(
        commonFriends, r'SearchUserDto', 'commonFriends');
    BuiltValueNullFieldError.checkNotNull(
        friendshipStatus, r'SearchUserDto', 'friendshipStatus');
  }

  @override
  SearchUserDto rebuild(void Function(SearchUserDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchUserDtoBuilder toBuilder() => new SearchUserDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchUserDto &&
        id == other.id &&
        name == other.name &&
        city == other.city &&
        country == other.country &&
        commonFriends == other.commonFriends &&
        friendshipStatus == other.friendshipStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, commonFriends.hashCode);
    _$hash = $jc(_$hash, friendshipStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SearchUserDto')
          ..add('id', id)
          ..add('name', name)
          ..add('city', city)
          ..add('country', country)
          ..add('commonFriends', commonFriends)
          ..add('friendshipStatus', friendshipStatus))
        .toString();
  }
}

class SearchUserDtoBuilder
    implements Builder<SearchUserDto, SearchUserDtoBuilder> {
  _$SearchUserDto? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  int? _commonFriends;
  int? get commonFriends => _$this._commonFriends;
  set commonFriends(int? commonFriends) =>
      _$this._commonFriends = commonFriends;

  EFriendshipStatus? _friendshipStatus;
  EFriendshipStatus? get friendshipStatus => _$this._friendshipStatus;
  set friendshipStatus(EFriendshipStatus? friendshipStatus) =>
      _$this._friendshipStatus = friendshipStatus;

  SearchUserDtoBuilder() {
    SearchUserDto._defaults(this);
  }

  SearchUserDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _city = $v.city;
      _country = $v.country;
      _commonFriends = $v.commonFriends;
      _friendshipStatus = $v.friendshipStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchUserDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SearchUserDto;
  }

  @override
  void update(void Function(SearchUserDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SearchUserDto build() => _build();

  _$SearchUserDto _build() {
    final _$result = _$v ??
        new _$SearchUserDto._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'SearchUserDto', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'SearchUserDto', 'name'),
          city: BuiltValueNullFieldError.checkNotNull(
              city, r'SearchUserDto', 'city'),
          country: BuiltValueNullFieldError.checkNotNull(
              country, r'SearchUserDto', 'country'),
          commonFriends: BuiltValueNullFieldError.checkNotNull(
              commonFriends, r'SearchUserDto', 'commonFriends'),
          friendshipStatus: BuiltValueNullFieldError.checkNotNull(
              friendshipStatus, r'SearchUserDto', 'friendshipStatus'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
