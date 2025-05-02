import 'package:shared/domain/tour_entity.dart';

abstract class TourFactory {
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
    required bool isPublic,
  });
}
