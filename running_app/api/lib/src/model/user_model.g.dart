// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserModel extends UserModel {
  @override
  final String? bio;
  @override
  final String? firstName;
  @override
  final int? id;
  @override
  final String? lastName;
  @override
  final String? passwordHash;
  @override
  final String? profilePictureUrl;
  @override
  final String? username;

  factory _$UserModel([void Function(UserModelBuilder)? updates]) =>
      (new UserModelBuilder()..update(updates))._build();

  _$UserModel._(
      {this.bio,
      this.firstName,
      this.id,
      this.lastName,
      this.passwordHash,
      this.profilePictureUrl,
      this.username})
      : super._();

  @override
  UserModel rebuild(void Function(UserModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserModelBuilder toBuilder() => new UserModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
        bio == other.bio &&
        firstName == other.firstName &&
        id == other.id &&
        lastName == other.lastName &&
        passwordHash == other.passwordHash &&
        profilePictureUrl == other.profilePictureUrl &&
        username == other.username;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, passwordHash.hashCode);
    _$hash = $jc(_$hash, profilePictureUrl.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserModel')
          ..add('bio', bio)
          ..add('firstName', firstName)
          ..add('id', id)
          ..add('lastName', lastName)
          ..add('passwordHash', passwordHash)
          ..add('profilePictureUrl', profilePictureUrl)
          ..add('username', username))
        .toString();
  }
}

class UserModelBuilder implements Builder<UserModel, UserModelBuilder> {
  _$UserModel? _$v;

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _passwordHash;
  String? get passwordHash => _$this._passwordHash;
  set passwordHash(String? passwordHash) => _$this._passwordHash = passwordHash;

  String? _profilePictureUrl;
  String? get profilePictureUrl => _$this._profilePictureUrl;
  set profilePictureUrl(String? profilePictureUrl) =>
      _$this._profilePictureUrl = profilePictureUrl;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  UserModelBuilder() {
    UserModel._defaults(this);
  }

  UserModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bio = $v.bio;
      _firstName = $v.firstName;
      _id = $v.id;
      _lastName = $v.lastName;
      _passwordHash = $v.passwordHash;
      _profilePictureUrl = $v.profilePictureUrl;
      _username = $v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserModel;
  }

  @override
  void update(void Function(UserModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserModel build() => _build();

  _$UserModel _build() {
    final _$result = _$v ??
        new _$UserModel._(
            bio: bio,
            firstName: firstName,
            id: id,
            lastName: lastName,
            passwordHash: passwordHash,
            profilePictureUrl: profilePictureUrl,
            username: username);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
