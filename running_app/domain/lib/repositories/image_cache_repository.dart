import 'dart:typed_data';

import 'package:domain/entities/view_area_entity.dart';

abstract class ImageCacheRepository {
  Uint8List? getCountryImage(String iso);

  void setStyleImage(int styleID, Uint8List rawImage);
  Uint8List? getStyleImageById(int styleID);

  void setNavigationInstructionImage(int imageUid, Uint8List? image);
  Uint8List? getNavigationInstructionImageByUid(int imageUid);
  void clearNavigationInstructionImageCache();

  PointEntity get flagSize;
  PointEntity get styleSize;
}
