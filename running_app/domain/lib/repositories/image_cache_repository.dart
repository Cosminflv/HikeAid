import 'dart:typed_data';

import 'package:domain/entities/view_area_entity.dart';

abstract class ImageCacheRepository {
  Uint8List? getCountryImage(String iso);

  void setNavigationInstructionImage(int imageUid, Uint8List? image);
  Uint8List? getNavigationInstructionImageByUid(int imageUid);
  void clearNavigationInstructionImageCache();

  PointEntity get flagSize;
}
