// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginDto extends LoginDto {
  @override
  final String? password;
  @override
  final String? username;

  factory _$LoginDto([void Function(LoginDtoBuilder)? updates]) =>
      (new LoginDtoBuilder()..update(updates))._build();

  _$LoginDto._({this.password, this.username}) : super._();

  @override
  LoginDto rebuild(void Function(LoginDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginDtoBuilder toBuilder() => new LoginDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginDto &&
        password == other.password &&
        username == other.username;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginDto')
          ..add('password', password)
          ..add('username', username))
        .toString();
  }
}

class LoginDtoBuilder implements Builder<LoginDto, LoginDtoBuilder> {
  _$LoginDto? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  LoginDtoBuilder() {
    LoginDto._defaults(this);
  }

  LoginDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _username = $v.username;
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
    final _$result =
        _$v ?? new _$LoginDto._(password: password, username: username);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
