import 'dart:typed_data';
import 'dart:ui';

import 'package:data/repositories_impl/extensions.dart';

import 'package:gem_kit/core.dart';
import 'package:image/image.dart' as img;
import 'package:shared/data/coordinates_entity_impl.dart';
import 'package:shared/domain/landmark_entity.dart';

class LandmarkEntityImpl extends LandmarkEntity {
  final Landmark? ref;
  final List<Landmark>? refList;

  LandmarkEntityImpl({
    required this.ref,
    super.icon,
    super.isPositionBased,
  })  : refList = null,
        super(
          name: ref!.name,
          address: ref.address.toAddressString(),
          countryCode: ref.address.getField(AddressField.countryCode),
          coordinates: ref.coordinates.toEntity(),
        );

  LandmarkEntityImpl.fromList({
    required this.refList,
  })  : ref = null,
        super(
            name: 'DrawnMarker',
            coordinates: CoordinatesEntityImpl(latitude: 0, longitude: 0),
            address: '',
            countryCode: '');

  @override
  void setImage(Uint8List image) {
    if (ref != null) {
      final originalImage = ref?.getImage(size: Size(128, 128), format: ImageFileFormat.png);

      ref?.setImage(imageData: image, format: ImageFileFormat.png);

      if (!hasExtraImage) {
        ref?.setExtraImage(imageData: originalImage!, format: ImageFileFormat.png);
      }
    }
  }

  @override
  Uint8List? get extraImage {
    return ref?.getImage(size: Size(128, 128), format: ImageFileFormat.png);
  }

  @override
  bool get hasExtraImage {
    if (extraImage == null || extraImage!.isEmpty) return false;
    img.Image image = img.decodeImage(extraImage!)!;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        if (image.getPixel(x, y).a != 0) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  Uint8List? get image {
    return ref?.getImage(size: Size(128, 128), format: ImageFileFormat.png);
  }

  @override
  int get id {
    final combinedString = '${ref!.coordinates.latitude.toString()}_${ref!.coordinates.longitude.toString()}';
    return combinedString.hashCode;
  }

  @override
  LandmarkEntity copy({Uint8List? image}) {
    final img = image ?? ref?.getImage(size: Size(128, 128), format: ImageFileFormat.png);

    final referenceCopy = toGemLandmark();
    referenceCopy.setImage(imageData: img!);

    final landmarkCopy = LandmarkEntityImpl(ref: referenceCopy, icon: img);

    return landmarkCopy;
  }
}
