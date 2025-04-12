import 'package:domain/entities/landmark_store_entity.dart';
import 'package:domain/repositories/landmark_store_repository.dart';
import 'package:shared/domain/landmark_entity.dart';

class LandmarkStoreUseCase {
  final LandmarkStoreEntity _searchHistoryStore;
  final LandmarkStoreEntity _savedPlacesStore;

  LandmarkStoreEntity getStore(DLandmarkStoreType type) => _getStoreByType(type);

  LandmarkStoreUseCase(LandmarkStoreRepository landmarkStoreRepository)
      : _searchHistoryStore = landmarkStoreRepository.getLandmarkStore(DLandmarkStoreType.searchHistory),
        _savedPlacesStore = landmarkStoreRepository.getLandmarkStore(DLandmarkStoreType.savedPlaces);

  List<LandmarkEntity> getLandmarks(DLandmarkStoreType type) {
    final store = _getStoreByType(type);
    return store.getItems();
  }

  bool addToStore(LandmarkEntity landmark, DLandmarkStoreType type) {
    final store = _getStoreByType(type);
    final isAlreadyInStore = store.contains(landmark);

    if (isAlreadyInStore && type == DLandmarkStoreType.searchHistory) {
      store.removeAll(landmark);
    }

    switch (type) {
      case DLandmarkStoreType.searchHistory:
        _searchHistoryStore.add(landmark);
        break;
      case DLandmarkStoreType.savedPlaces:
        _savedPlacesStore.add(landmark);
        break;
    }
    return !isAlreadyInStore;
  }

  bool removeFromStore(LandmarkEntity landmark, DLandmarkStoreType type) {
    switch (type) {
      case DLandmarkStoreType.searchHistory:
        _searchHistoryStore.removeLandmark(landmark);
        break;
      case DLandmarkStoreType.savedPlaces:
        _savedPlacesStore.removeLandmark(landmark);
        break;
    }
    return true;
  }

  LandmarkStoreEntity _getStoreByType(DLandmarkStoreType type) {
    switch (type) {
      case DLandmarkStoreType.searchHistory:
        return _searchHistoryStore;
      case DLandmarkStoreType.savedPlaces:
        return _savedPlacesStore;
    }
  }

  void clearItems(DLandmarkStoreType type) {
    final store = _getStoreByType(type);
    store.clear();
  }
}
