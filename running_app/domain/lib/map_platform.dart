import 'dart:typed_data';

enum ThemeType { day, night }

abstract class MapPlatform {
  Uint8List getImage({required ThemeType type, required int width, required int height});
}
