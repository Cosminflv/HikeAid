import 'dart:typed_data';

abstract class ImageCacheRepository {
  void setNavigationInstructionImage(int imageUid, Uint8List? image);
  Uint8List? getNavigationInstructionImageByUid(int imageUid);
  void clearNavigationInstructionImageCache();
}
