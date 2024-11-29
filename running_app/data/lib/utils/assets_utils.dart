import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:path_provider/path_provider.dart';

Future<String> copyAssetStyleToSceneRes(String assetName) async {
  late Directory dirPath;
  if (Platform.isAndroid) {
    dirPath = (await getExternalStorageDirectory())!;
  } else if (Platform.isIOS) {
    dirPath = await getApplicationDocumentsDirectory();
  }

  final name = assetName.split('/').last;
  final sceneResDirPath = "${dirPath.path}/Data/SceneRes/$name";

  File file = File(sceneResDirPath);
  if (await file.exists()) {
    int phoneFileSize = await file.length();

    ByteData data = await rootBundle.load(assetName);
    List<int> assetBytes = data.buffer.asUint8List();
    int assetFileSize = assetBytes.length;

    if (phoneFileSize == assetFileSize) return sceneResDirPath;
    await file.writeAsBytes(assetBytes);
    return file.path;
  }
  await file.create();

  final styleAsset = await rootBundle.load(assetName);
  final buffer = styleAsset.buffer;
  await file.writeAsBytes(buffer.asUint8List(styleAsset.offsetInBytes, styleAsset.lengthInBytes), flush: true);
  print("Wrote file ${file.path}");
  return file.path;
}

Future<Uint8List> assetToUint8List(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  return byteData.buffer.asUint8List();
}
