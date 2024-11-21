import 'package:flutter/services.dart';

Future<Uint8List> assetToUint8List(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  return byteData.buffer.asUint8List();
}
