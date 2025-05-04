import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/repositories/image_cache_repository.dart';

import 'dart:typed_data';

import 'package:gem_kit/map.dart';

import 'dart:ui';

class ImageCacheRepositoryImpl extends ImageCacheRepository {
  final PointEntity _flagSize;

  final Map<String, Uint8List> _countryImages;
  final Map<int, Uint8List> _navigationInstructionsImages;

  ImageCacheRepositoryImpl(this._flagSize)
      : _countryImages = {},
        _navigationInstructionsImages = {};

  @override
  Uint8List? getCountryImage(String iso) {
    var image = _countryImages[iso];

    if (image == null) {
      image = MapDetails.getCountryFlag(countryCode: iso, size: Size(_flagSize.x.toDouble(), _flagSize.y.toDouble()));
      if (image != null) {
        _countryImages[iso] = image;
      }
    }

    return image;
  }

  @override
  PointEntity get flagSize => _flagSize;

  @override
  void setNavigationInstructionImage(int imageUid, Uint8List? image) {
    if (image == null) return;

    const maxSizeNavInstructionImageCache = 10;
    if (_navigationInstructionsImages.length > maxSizeNavInstructionImageCache) {
      clearNavigationInstructionImageCache();
    }

    _navigationInstructionsImages[imageUid] = image;
  }

  @override
  Uint8List? getNavigationInstructionImageByUid(int imageUid) {
    return _navigationInstructionsImages[imageUid];
  }

  @override
  void clearNavigationInstructionImageCache() {
    _navigationInstructionsImages.clear();
  }
}
