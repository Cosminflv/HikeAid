import 'package:data/models/landmark_store_entity_impl.dart';
import 'package:domain/entities/landmark_store_entity.dart';
import 'package:domain/repositories/landmark_store_repository.dart';


class LandmarkStoreRepositoryImpl extends LandmarkStoreRepository {
  @override
  LandmarkStoreEntity getLandmarkStore(DLandmarkStoreType type) => LandmarkStoreEntityImpl(type: type);
}
