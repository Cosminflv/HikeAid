import 'dart:typed_data';

import 'package:shared/data/tour_entity_impl.dart';
import 'package:shared/domain/tour_entity.dart';
import 'package:shared/factories/tour_factory.dart';

class TourFactoryImpl extends TourFactory {
  @override
  TourEntity produce({
    int id = -1,
    String fileId = '',
    int authorId = 0,
    required String name,
    required DateTime date,
    required int distance,
    required int duration,
    required int totalUp,
    required int totalDown,
    required List<CoordinatesWithTimestamp> coordinates,
    required Uint8List previewImage,
    required TourType type,
    required bool isPublic,
  }) =>
      TourEntityImpl(
        id: id,
        fileId: fileId,
        authorId: authorId,
        name: name,
        date: date,
        distance: distance,
        duration: duration,
        totalUp: totalUp,
        totalDown: totalDown,
        coordinates: coordinates,
        previewImage: previewImage,
        type: type,
      );
}
