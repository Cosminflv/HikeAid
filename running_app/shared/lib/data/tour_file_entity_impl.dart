import 'package:shared/domain/tour_file_entity.dart';
import 'package:shared/domain/tour_entity.dart';

class TourFileEntityImpl extends TourFileEntity {
  TourFileEntityImpl({
    super.remoteName,
    super.localPath,
    required super.distance,
  });

  @override
  TourFileEntity copyWithName(String name) => TourFileEntityImpl(
        remoteName: name,
        localPath: localPath,
        distance: distance,
      );

  @override
  String? getImageURL(TourEntity tour) => 'myUrl';

  factory TourFileEntityImpl.fromJson(Map<String, dynamic> json) => TourFileEntityImpl(
        distance: json['distance_on_tour'],
        remoteName: json['file_name'],
      );
}
