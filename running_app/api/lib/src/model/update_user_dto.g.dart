// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateUserDto extends UpdateUserDto {
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String bio;
  @override
  final int age;
  @override
  final String country;
  @override
  final String city;
  @override
  final EGender gender;
  @override
  final DateTime birthDate;
  @override
  final int weight;
  @override
  final bool hasDeletedImage;
  @override
  final String imageData;

  factory _$UpdateUserDto([void Function(UpdateUserDtoBuilder)? updates]) =>
      (new UpdateUserDtoBuilder()..update(updates))._build();

  _$UpdateUserDto._(
      {required this.firstName,
      required this.lastName,
      required this.bio,
      required this.age,
      required this.country,
      required this.city,
      required this.gender,
      required this.birthDate,
      required this.weight,
      required this.hasDeletedImage,
      required this.imageData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firstName, r'UpdateUserDto', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        lastName, r'UpdateUserDto', 'lastName');
    BuiltValueNullFieldError.checkNotNull(bio, r'UpdateUserDto', 'bio');
    BuiltValueNullFieldError.checkNotNull(age, r'UpdateUserDto', 'age');
    BuiltValueNullFieldError.checkNotNull(country, r'UpdateUserDto', 'country');
    BuiltValueNullFieldError.checkNotNull(city, r'UpdateUserDto', 'city');
    BuiltValueNullFieldError.checkNotNull(gender, r'UpdateUserDto', 'gender');
    BuiltValueNullFieldError.checkNotNull(
        birthDate, r'UpdateUserDto', 'birthDate');
    BuiltValueNullFieldError.checkNotNull(weight, r'UpdateUserDto', 'weight');
    BuiltValueNullFieldError.checkNotNull(
        hasDeletedImage, r'UpdateUserDto', 'hasDeletedImage');
    BuiltValueNullFieldError.checkNotNull(
        imageData, r'UpdateUserDto', 'imageData');
  }

  @override
  UpdateUserDto rebuild(void Function(UpdateUserDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateUserDtoBuilder toBuilder() => new UpdateUserDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateUserDto &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        bio == other.bio &&
        age == other.age &&
        country == other.country &&
        city == other.city &&
        gender == other.gender &&
        birthDate == other.birthDate &&
        weight == other.weight &&
        hasDeletedImage == other.hasDeletedImage &&
        imageData == other.imageData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, gender.hashCode);
    _$hash = $jc(_$hash, birthDate.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, hasDeletedImage.hashCode);
    _$hash = $jc(_$hash, imageData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateUserDto')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('bio', bio)
          ..add('age', age)
          ..add('country', country)
          ..add('city', city)
          ..add('gender', gender)
          ..add('birthDate', birthDate)
          ..add('weight', weight)
          ..add('hasDeletedImage', hasDeletedImage)
          ..add('imageData', imageData))
        .toString();
  }
}

class UpdateUserDtoBuilder
    implements Builder<UpdateUserDto, UpdateUserDtoBuilder> {
  _$UpdateUserDto? _$v;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

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

  EGender? _gender;
  EGender? get gender => _$this._gender;
  set gender(EGender? gender) => _$this._gender = gender;

  DateTime? _birthDate;
  DateTime? get birthDate => _$this._birthDate;
  set birthDate(DateTime? birthDate) => _$this._birthDate = birthDate;

  int? _weight;
  int? get weight => _$this._weight;
  set weight(int? weight) => _$this._weight = weight;

  bool? _hasDeletedImage;
  bool? get hasDeletedImage => _$this._hasDeletedImage;
  set hasDeletedImage(bool? hasDeletedImage) =>
      _$this._hasDeletedImage = hasDeletedImage;

  String? _imageData;
  String? get imageData => _$this._imageData;
  set imageData(String? imageData) => _$this._imageData = imageData;

  UpdateUserDtoBuilder() {
    UpdateUserDto._defaults(this);
  }

  UpdateUserDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _bio = $v.bio;
      _age = $v.age;
      _country = $v.country;
      _city = $v.city;
      _gender = $v.gender;
      _birthDate = $v.birthDate;
      _weight = $v.weight;
      _hasDeletedImage = $v.hasDeletedImage;
      _imageData = $v.imageData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateUserDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateUserDto;
  }

  @override
  void update(void Function(UpdateUserDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateUserDto build() => _build();

  _$UpdateUserDto _build() {
    final _$result = _$v ??
        new _$UpdateUserDto._(
          firstName: BuiltValueNullFieldError.checkNotNull(
              firstName, r'UpdateUserDto', 'firstName'),
          lastName: BuiltValueNullFieldError.checkNotNull(
              lastName, r'UpdateUserDto', 'lastName'),
          bio: BuiltValueNullFieldError.checkNotNull(
              bio, r'UpdateUserDto', 'bio'),
          age: BuiltValueNullFieldError.checkNotNull(
              age, r'UpdateUserDto', 'age'),
          country: BuiltValueNullFieldError.checkNotNull(
              country, r'UpdateUserDto', 'country'),
          city: BuiltValueNullFieldError.checkNotNull(
              city, r'UpdateUserDto', 'city'),
          gender: BuiltValueNullFieldError.checkNotNull(
              gender, r'UpdateUserDto', 'gender'),
          birthDate: BuiltValueNullFieldError.checkNotNull(
              birthDate, r'UpdateUserDto', 'birthDate'),
          weight: BuiltValueNullFieldError.checkNotNull(
              weight, r'UpdateUserDto', 'weight'),
          hasDeletedImage: BuiltValueNullFieldError.checkNotNull(
              hasDeletedImage, r'UpdateUserDto', 'hasDeletedImage'),
          imageData: BuiltValueNullFieldError.checkNotNull(
              imageData, r'UpdateUserDto', 'imageData'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
