import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' as io;

class OSCompatibilityChecker {
  static final _deviceInfo = DeviceInfoPlugin();

  static Future<bool> canApplyMapStyle() async {
    if (io.Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;

      return iosInfo.isPhysicalDevice;
    }
    if (io.Platform.isAndroid) {
      return true;
    }
    return false;
  }
}
