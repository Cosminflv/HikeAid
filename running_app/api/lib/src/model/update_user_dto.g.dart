// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateUserDto extends UpdateUserDto {
  @override
  final int? id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? bio;
  @override
  final bool? hasDeletedImage;
  @override
  final String? imageData;

  factory _$UpdateUserDto([void Function(UpdateUserDtoBuilder)? updates]) =>
      (new UpdateUserDtoBuilder()..update(updates))._build();

  _$UpdateUserDto._(
      {this.id,
      this.firstName,
      this.lastName,
      this.bio,
      this.hasDeletedImage,
      this.imageData})
      : super._();

  @override
  UpdateUserDto rebuild(void Function(UpdateUserDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateUserDtoBuilder toBuilder() => new UpdateUserDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateUserDto &&
        id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        bio == other.bio &&
        hasDeletedImage == other.hasDeletedImage &&
        imageData == other.imageData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, hasDeletedImage.hashCode);
    _$hash = $jc(_$hash, imageData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateUserDto')
          ..add('id', id)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('bio', bio)
          ..add('hasDeletedImage', hasDeletedImage)
          ..add('imageData', imageData))
        .toString();
  }
}

class UpdateUserDtoBuilder
    implements Builder<UpdateUserDto, UpdateUserDtoBuilder> {
  _$UpdateUserDto? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

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
      _id = $v.id;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _bio = $v.bio;
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
            id: id,
            firstName: firstName,
            lastName: lastName,
            bio: bio,
            hasDeletedImage: hasDeletedImage,
            imageData: imageData);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
