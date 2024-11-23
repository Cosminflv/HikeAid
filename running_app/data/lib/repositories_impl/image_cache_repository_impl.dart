import 'package:domain/repositories/image_cache_repository.dart';

import 'dart:typed_data';

class ImageCacheRepositoryImpl extends ImageCacheRepository {
  final Map<int, Uint8List> _navigationInstructionsImages;

  ImageCacheRepositoryImpl() : _navigationInstructionsImages = {};

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
