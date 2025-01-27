// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserDto extends UserDto {
  @override
  final String? username;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? passwordHash;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final int? weight;
  @override
  final EGender? eGender;
  @override
  final DateTime? birthdate;

  factory _$UserDto([void Function(UserDtoBuilder)? updates]) =>
      (new UserDtoBuilder()..update(updates))._build();

  _$UserDto._(
      {this.username,
      this.firstName,
      this.lastName,
      this.passwordHash,
      this.city,
      this.country,
      this.weight,
      this.eGender,
      this.birthdate})
      : super._();

  @override
  UserDto rebuild(void Function(UserDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserDtoBuilder toBuilder() => new UserDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDto &&
        username == other.username &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        passwordHash == other.passwordHash &&
        city == other.city &&
        country == other.country &&
        weight == other.weight &&
        eGender == other.eGender &&
        birthdate == other.birthdate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, passwordHash.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, eGender.hashCode);
    _$hash = $jc(_$hash, birthdate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserDto')
          ..add('username', username)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('passwordHash', passwordHash)
          ..add('city', city)
          ..add('country', country)
          ..add('weight', weight)
          ..add('eGender', eGender)
          ..add('birthdate', birthdate))
        .toString();
  }
}

class UserDtoBuilder implements Builder<UserDto, UserDtoBuilder> {
  _$UserDto? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _passwordHash;
  String? get passwordHash => _$this._passwordHash;
  set passwordHash(String? passwordHash) => _$this._passwordHash = passwordHash;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  int? _weight;
  int? get weight => _$this._weight;
  set weight(int? weight) => _$this._weight = weight;

  EGender? _eGender;
  EGender? get eGender => _$this._eGender;
  set eGender(EGender? eGender) => _$this._eGender = eGender;

  DateTime? _birthdate;
  DateTime? get birthdate => _$this._birthdate;
  set birthdate(DateTime? birthdate) => _$this._birthdate = birthdate;

  UserDtoBuilder() {
    UserDto._defaults(this);
  }

  UserDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _passwordHash = $v.passwordHash;
      _city = $v.city;
      _country = $v.country;
      _weight = $v.weight;
      _eGender = $v.eGender;
      _birthdate = $v.birthdate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserDto;
  }

  @override
  void update(void Function(UserDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserDto build() => _build();

  _$UserDto _build() {
    final _$result = _$v ??
        new _$UserDto._(
          username: username,
          firstName: firstName,
          lastName: lastName,
          passwordHash: passwordHash,
          city: city,
          country: country,
          weight: weight,
          eGender: eGender,
          birthdate: birthdate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
