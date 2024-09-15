import 'dart:typed_data';

abstract class AssetBundleEntity {
  Future<Uint8List> loadAsUint8List(String filename);
}
