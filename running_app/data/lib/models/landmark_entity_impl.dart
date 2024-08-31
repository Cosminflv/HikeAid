import 'dart:typed_data';
import 'dart:ui';

import 'package:data/models/coordinates_entity_impl.dart';
import 'package:data/repositories_impl/extensions.dart';

import 'package:domain/entities/landmark_entity.dart';

import 'package:gem_kit/core.dart';

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
          coordinates: ref.coordinates.toEntityImpl(),
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
      ref?.setExtraImage(imageData: originalImage!, format: ImageFileFormat.png);

      ref?.setImage(imageData: image, format: ImageFileFormat.png);
    }
  }

  @override
  Uint8List? get extraImage => ref?.getExtraImage(size: Size(128, 128), format: ImageFileFormat.png);

  @override
  int get id {
    final combinedString = '${ref!.coordinates.latitude.toString()}_${ref!.coordinates.longitude.toString()}';
    return combinedString.hashCode;
  }
}
