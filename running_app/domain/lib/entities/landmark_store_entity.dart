import 'package:domain/entities/landmark_category_entity.dart';
import 'package:domain/entities/landmark_entity.dart';

enum DLandmarkStoreType {
  searchHistory("searchHistory"),
  savedPlaces("savedPlaces");

  final String _text;
  const DLandmarkStoreType(this._text);

  @override
  String toString() {
    return _text;
  }
}

abstract class LandmarkStoreEntity {
  final DLandmarkStoreType type;

  LandmarkStoreEntity({required this.type});

  int get size;

  bool add(LandmarkEntity landmark);
  List<LandmarkEntity> getItems({LandmarkCategoryEntity? category});
  bool contains(LandmarkEntity landmark);
  bool removeLandmark(LandmarkEntity landmark);

  bool removeAll(LandmarkEntity landmark);

  void clear();
}
