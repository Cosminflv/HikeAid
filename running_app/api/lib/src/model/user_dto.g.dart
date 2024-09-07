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

  factory _$UserDto([void Function(UserDtoBuilder)? updates]) =>
      (new UserDtoBuilder()..update(updates))._build();

  _$UserDto._({this.username, this.firstName, this.lastName, this.passwordHash})
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
        passwordHash == other.passwordHash;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, passwordHash.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserDto')
          ..add('username', username)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('passwordHash', passwordHash))
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
            passwordHash: passwordHash);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
