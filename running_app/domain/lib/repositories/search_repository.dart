import 'package:domain/entities/coordinates_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:domain/entities/landmark_category_entity.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';

typedef SearchResult = Either<int, List<LandmarkWithDistanceEntity>>;

enum DAddressDetailLevel {
  noDetail,
  country,
  state,
  county,
  district,
  city,
  settlement,
  postalCode,
  street,
  streetSection,
  streetLane,
  streetAlley,
  houseNumber,
  crossing,
}

abstract class SearchRepository {
  TaskProgressListener search(
      {required String text, required CoordinatesEntity coordinates, required Function(SearchResult) onResult});

  TaskProgressListener searchWithCategory(
      {required LandmarkCategoryEntity category,
      required CoordinatesEntity coordinates,
      required Function(SearchResult) onResult});

  void cancelSearch(TaskProgressListener listener);
  void cancelAddressSearch(TaskProgressListener listener);
}
