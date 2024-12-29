import 'package:domain/entities/landmark_store_entity.dart';

/// A repository interface for managing and accessing landmark stores.
///
/// The [LandmarkStoreRepository] provides methods to retrieve a [LandmarkStoreEntity]
/// based on a specific landmark store type.
abstract class LandmarkStoreRepository {
  /// Retrieves a [LandmarkStoreEntity] for the given [type].
  ///
  /// The method returns a landmark store based on the provided type, which could represent
  /// a particular category or source of landmarks (e.g., points of interest, user-added landmarks, etc.).
  ///
  /// - Parameters:
  ///   - [type]: The [DLandmarkStoreType] representing the type of landmark store to retrieve.
  ///
  /// - Returns: A [LandmarkStoreEntity] representing the store of landmarks for the given type.
  LandmarkStoreEntity getLandmarkStore(DLandmarkStoreType type);
}
