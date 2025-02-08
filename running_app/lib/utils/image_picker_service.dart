import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<Uint8List?> pickAndCompressImage({required int minWidth, required int minHeight}) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) return null;

      return await _compressImage(pickedFile, minWidth, minHeight);
    } catch (e) {
      debugPrint('Image compression error: $e');
      return null;
    }
  }

  Future<Uint8List?> _compressImage(XFile file, int minWidth, int minHeight) async {
    try {
      final Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
        file.path,
        quality: 75,
        minWidth: minWidth,
        minHeight: minHeight,
      );

      return compressedBytes;
    } catch (e) {
      debugPrint('Image compression failed: $e');
      return null;
    }
  }
}
