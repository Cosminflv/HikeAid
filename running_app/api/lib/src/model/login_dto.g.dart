// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginDto extends LoginDto {
  @override
  final String username;
  @override
  final String password;

  factory _$LoginDto([void Function(LoginDtoBuilder)? updates]) =>
      (new LoginDtoBuilder()..update(updates))._build();

  _$LoginDto._({required this.username, required this.password}) : super._() {
    BuiltValueNullFieldError.checkNotNull(username, r'LoginDto', 'username');
    BuiltValueNullFieldError.checkNotNull(password, r'LoginDto', 'password');
  }

  @override
  LoginDto rebuild(void Function(LoginDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginDtoBuilder toBuilder() => new LoginDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginDto &&
        username == other.username &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginDto')
          ..add('username', username)
          ..add('password', password))
        .toString();
  }
}

class LoginDtoBuilder implements Builder<LoginDto, LoginDtoBuilder> {
  _$LoginDto? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  LoginDtoBuilder() {
    LoginDto._defaults(this);
  }

  LoginDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginDto;
  }

  @override
  void update(void Function(LoginDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginDto build() => _build();

  _$LoginDto _build() {
    final _$result = _$v ??
        new _$LoginDto._(
          username: BuiltValueNullFieldError.checkNotNull(
              username, r'LoginDto', 'username'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'LoginDto', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
