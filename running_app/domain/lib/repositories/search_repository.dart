import 'package:dartz/dartz.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:domain/repositories/task_progress_listener.dart';
import 'package:shared/domain/coordinates_entity.dart';

/// A repository interface for performing advanced search operations.
///
/// This repository provides methods to search for landmarks or addresses based on
/// text queries, categories, and geographical coordinates. It also supports the
/// cancellation of ongoing search operations.
abstract class SearchRepository {
  /// Searches for landmarks or addresses near the specified [coordinates]
  /// that match the provided [text] query.
  ///
  /// - Parameters:
  ///   - [text]: The search query string.
  ///   - [coordinates]: A [CoordinatesEntity] representing the geographical location
  ///     to narrow the search results.
  ///   - [onResult]: A callback function that is invoked with a [SearchResult].
  ///     The result is an [Either<int, List<LandmarkWithDistanceEntity>>], where:
  ///     - `Left<int>` represents an error code.
  ///     - `Right<List<LandmarkWithDistanceEntity>>` contains the search results.
  /// - Returns: A [TaskProgressListener] that can be used to monitor or cancel the
  ///   search operation.
  /// - Throws:
  ///   - [SomeSpecificException] if the search fails due to network or processing errors.
  TaskProgressListener search({
    required String text,
    required CoordinatesEntity coordinates,
    required Function(SearchResult) onResult,
  });

  /// Cancels an ongoing search operation identified by the provided [listener].
  ///
  /// - Parameters:
  ///   - [listener]: A [TaskProgressListener] associated with the ongoing search.
  /// - Throws:
  ///   - [SomeSpecificException] if the cancellation fails.
  void cancelSearch(TaskProgressListener listener);

  /// Cancels an ongoing address search operation identified by the provided [listener].
  ///
  /// - Parameters:
  ///   - [listener]: A [TaskProgressListener] associated with the ongoing address search.
  /// - Throws:
  ///   - [SomeSpecificException] if the cancellation fails.
  void cancelAddressSearch(TaskProgressListener listener);
}

/// An enumeration representing the level of detail for address searches.
///
/// The levels range from no detail to highly specific details such as a house number or street section.
enum DAddressDetailLevel {
  /// No detail is required.
  noDetail,

  /// Country-level detail.
  country,

  /// State or province-level detail.
  state,

  /// County-level detail.
  county,

  /// District-level detail.
  district,

  /// City-level detail.
  city,

  /// Settlement-level detail.
  settlement,

  /// Postal code-level detail.
  postalCode,

  /// Street-level detail.
  street,

  /// Street section-level detail.
  streetSection,

  /// Street lane-level detail.
  streetLane,

  /// Street alley-level detail.
  streetAlley,

  /// House number-level detail.
  houseNumber,

  /// Crossing-level detail.
  crossing,
}

/// A type alias for search results.
///
/// - `Left<int>`: Represents an error code.
/// - `Right<List<LandmarkWithDistanceEntity>>`: Contains a list of search results with distances.
typedef SearchResult = Either<int, List<LandmarkWithDistanceEntity>>;
