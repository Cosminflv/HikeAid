import 'package:data/models/landmark_entity_impl.dart';
import 'package:data/repositories_impl/extensions.dart';

import 'package:domain/entities/landmark_store_entity.dart';

import 'package:gem_kit/landmark_store.dart';
import 'package:shared/domain/landmark_entity.dart';

class LandmarkStoreEntityImpl extends LandmarkStoreEntity {
  final LandmarkStore _landmarkStore;

  LandmarkStore get ref => _landmarkStore;

  @override
  int get size => _landmarkStore.getLandmarks().length;

  LandmarkStoreEntityImpl({required super.type}) : _landmarkStore = _getLandmarkStore(type);

  @override
  bool add(LandmarkEntity landmark) {
    if (landmark is! LandmarkEntityImpl) return false;

    _landmarkStore.addLandmark(landmark.ref!);

    return true;
  }

  @override
  void clear() {
    _landmarkStore.clear();
  }

  static LandmarkStore _getLandmarkStore(DLandmarkStoreType type) =>
      LandmarkStoreService.getLandmarkStoreByName(type.name) ?? LandmarkStoreService.createLandmarkStore(type.name);

  @override
  List<LandmarkEntity> getItems() {
    // FIXME the categoryId is ignored in the SDK for the moment
    // LandmarkStore.getLandmarks(category) should solve it
    final landmarks = _landmarkStore.getLandmarks();

    return landmarks.map((e) => e.toEntityImpl()).toList();
  }

  @override
  bool removeAll(LandmarkEntity landmark) {
    final items = getItems();

    final initialSize = items.length;
    for (final item in items) {
      if (item != landmark) continue;
      removeLandmark(item);
    }
    items.removeWhere((element) => element == landmark);

    return items.length < initialSize;
  }

  @override
  bool contains(LandmarkEntity landmark) {
    final items = getItems();

    return items.contains(landmark);
  }

  @override
  bool removeLandmark(LandmarkEntity landmark) {
    if (landmark is! LandmarkEntityImpl) return false;
    _landmarkStore.removeLandmark(landmark.ref!);
    return true;
  }
}
