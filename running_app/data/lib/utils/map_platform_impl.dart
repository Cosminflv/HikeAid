import 'dart:typed_data';
import 'dart:ui';

import 'package:domain/map_platform.dart';
import 'package:gem_kit/core.dart';

class MapPlatformImpl extends MapPlatform {
  @override
  Uint8List getImage({required ThemeType type, required int width, required int height}) {
    switch (type) {
      case ThemeType.day:
        return SdkSettings.getImageById(
            id: EngineMisc.compassEnableSensorOFF.id, size: Size(width.toDouble(), height.toDouble()))!;
      case ThemeType.night:
        return SdkSettings.getImageById(
            id: EngineMisc.compassEnableSensorOFFnight.id, size: Size(width.toDouble(), height.toDouble()))!;
    }
  }
}
