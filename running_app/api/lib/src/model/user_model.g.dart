// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserModel extends UserModel {
  @override
  final int? id;
  @override
  final String? username;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? passwordHash;
  @override
  final String? bio;
  @override
  final int? age;
  @override
  final String? country;
  @override
  final String? city;
  @override
  final int? weight;
  @override
  final EGender? gender;
  @override
  final DateTime? birthDate;
  @override
  final String? profilePictureUrl;

  factory _$UserModel([void Function(UserModelBuilder)? updates]) =>
      (new UserModelBuilder()..update(updates))._build();

  _$UserModel._(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.passwordHash,
      this.bio,
      this.age,
      this.country,
      this.city,
      this.weight,
      this.gender,
      this.birthDate,
      this.profilePictureUrl})
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
        id == other.id &&
        username == other.username &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        passwordHash == other.passwordHash &&
        bio == other.bio &&
        age == other.age &&
        country == other.country &&
        city == other.city &&
        weight == other.weight &&
        gender == other.gender &&
        birthDate == other.birthDate &&
        profilePictureUrl == other.profilePictureUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, passwordHash.hashCode);
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, gender.hashCode);
    _$hash = $jc(_$hash, birthDate.hashCode);
    _$hash = $jc(_$hash, profilePictureUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserModel')
          ..add('id', id)
          ..add('username', username)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('passwordHash', passwordHash)
          ..add('bio', bio)
          ..add('age', age)
          ..add('country', country)
          ..add('city', city)
          ..add('weight', weight)
          ..add('gender', gender)
          ..add('birthDate', birthDate)
          ..add('profilePictureUrl', profilePictureUrl))
        .toString();
  }
}

class UserModelBuilder implements Builder<UserModel, UserModelBuilder> {
  _$UserModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  int? _weight;
  int? get weight => _$this._weight;
  set weight(int? weight) => _$this._weight = weight;

  EGender? _gender;
  EGender? get gender => _$this._gender;
  set gender(EGender? gender) => _$this._gender = gender;

  DateTime? _birthDate;
  DateTime? get birthDate => _$this._birthDate;
  set birthDate(DateTime? birthDate) => _$this._birthDate = birthDate;

  String? _profilePictureUrl;
  String? get profilePictureUrl => _$this._profilePictureUrl;
  set profilePictureUrl(String? profilePictureUrl) =>
      _$this._profilePictureUrl = profilePictureUrl;

  UserModelBuilder() {
    UserModel._defaults(this);
  }

  UserModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _username = $v.username;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _passwordHash = $v.passwordHash;
      _bio = $v.bio;
      _age = $v.age;
      _country = $v.country;
      _city = $v.city;
      _weight = $v.weight;
      _gender = $v.gender;
      _birthDate = $v.birthDate;
      _profilePictureUrl = $v.profilePictureUrl;
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
            id: id,
            username: username,
            firstName: firstName,
            lastName: lastName,
            passwordHash: passwordHash,
            bio: bio,
            age: age,
            country: country,
            city: city,
            weight: weight,
            gender: gender,
            birthDate: birthDate,
            profilePictureUrl: profilePictureUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
