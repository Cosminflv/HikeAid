import 'package:domain/entities/landmark_store_entity.dart';

abstract class LandmarkStoreRepository {
  LandmarkStoreEntity getLandmarkStore(DLandmarkStoreType type);
}
