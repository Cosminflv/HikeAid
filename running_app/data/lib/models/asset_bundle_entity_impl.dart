import 'package:domain/entities/asset_bundle_entity.dart';
import 'package:flutter/services.dart';

class AssetBundleEntityImpl implements AssetBundleEntity {
  @override
  Future<Uint8List> loadAsUint8List(String filename) async {
    ByteData fileData = await rootBundle.load(filename);
    final bytes = fileData.buffer.asUint8List();
    return bytes;
  }
}
