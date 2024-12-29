import 'package:domain/entities/search_user_entity.dart';

/// A repository interface for searching users within the application.
///
/// This repository defines the contract for performing user searches
/// based on a search query. Implementations may retrieve results from
/// various sources such as a remote server, a database, or in-memory data.
abstract class SearchUsersRepository {
  /// Searches for users matching the specified [text] query.
  ///
  /// - Parameters:
  ///   - [text]: The search query string used to find users.
  ///   - [onResult]: A callback function that is invoked with a list of
  ///     [SearchUserEntity] objects when the search results are available.
  /// - Returns: A [Future] that completes when the search operation is finalized.
  /// - Throws:
  ///   - [SomeSpecificException] if the search fails due to network, database,
  ///     or other issues.
  ///
  /// ### Usage:
  /// ```dart
  /// await searchUsersRepository.search(
  ///   text: "john",
  ///   onResult: (results) {
  ///     for (var user in results) {
  ///       print("Found user: ${user.name}");
  ///     }
  ///   },
  /// );
  /// ```
  Future<void> search({
    required String text,
    required Function(List<SearchUserEntity> results) onResult,
  });
}
