import 'package:domain/entities/coordinates_entity.dart';
import 'package:domain/entities/landmark_entity.dart';

/// A repository interface for managing landmarks and performing operations related to landmarks.
///
/// The [LandmarkRepository] provides methods to fetch landmark details based on coordinates,
/// find the closest landmarks to a given location, and perform other location-based queries.
abstract class LandmarkRepository {
  /// Retrieves a [LandmarkEntity] at the specified [coordinates].
  ///
  /// This method allows the retrieval of a landmark based on specific geographical coordinates.
  /// Optionally, the name and position-based flags can be provided to refine the search.
  ///
  /// - Parameters:
  ///   - [coordinates]: The [CoordinatesEntity] representing the geographic location to look for a landmark.
  ///   - [name]: An optional [String] that can be used to filter the landmark by name.
  ///   - [isPositionBased]: An optional [bool] flag that can specify if the landmark should be position-based.
  ///
  /// - Returns: A [LandmarkEntity] representing the landmark found at the specified coordinates,
  ///   or `null` if no landmark is found at those coordinates.
  LandmarkEntity getLandmarkAtCoordinates({
    required CoordinatesEntity coordinates,
    String? name,
    bool? isPositionBased,
  });

  /// Retrieves the closest landmark to the specified [coordinates].
  ///
  /// This method provides a [Future] to asynchronously fetch the closest [LandmarkEntity] to
  /// the given location.
  ///
  /// - Parameters:
  ///   - [coordinates]: The [CoordinatesEntity] representing the geographic location from which to find the closest landmark.
  ///
  /// - Returns: A [Future] that resolves to a [LandmarkEntity] representing the closest landmark to the
  ///   specified coordinates, or `null` if no landmark is found.
  Future<LandmarkEntity?> getClosestLandmark(CoordinatesEntity coordinates);
}
