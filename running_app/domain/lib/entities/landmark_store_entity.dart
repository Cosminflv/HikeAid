import 'package:shared/domain/landmark_entity.dart';

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
  bool contains(LandmarkEntity landmark);
  List<LandmarkEntity> getItems();
  bool removeLandmark(LandmarkEntity landmark);

  bool removeAll(LandmarkEntity landmark);

  void clear();
}
