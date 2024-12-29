import 'package:domain/entities/friendship_entity.dart';

/// A repository interface for managing and handling friendships and friendship requests.
///
/// The [FriendshipRepository] provides methods to send, accept, decline friendship requests,
/// manage friendship notifications, and retrieve friendship request data.
abstract class FriendshipRepository {
  /// Fetches the list of pending friendship requests for the current user.
  ///
  /// This method retrieves all incoming friendship requests that are pending and awaiting
  /// the user's action (either acceptance or decline).
  ///
  /// - Returns: A [Future<List<FriendshipEntity>>] that resolves to a list of [FriendshipEntity]
  ///   objects representing the friendship requests.
  Future<List<FriendshipEntity>> fetchRequests();

  /// Establishes a connection to receive notifications about friendship status changes.
  ///
  /// This method opens a connection to listen for real-time friendship-related notifications.
  /// When a notification is received, the provided callback is invoked with the error message (if any)
  /// and the associated [FriendshipEntity] object containing the friendship details.
  ///
  /// - Parameters:
  ///   - [userId]: The unique identifier for the user to monitor friendship notifications for.
  ///   - [onNotificationReceived]: A callback function that is called when a notification is received.
  ///     It takes an [err] message (a [String]) and an optional [FriendshipEntity] as arguments.
  void establishNotificationsConnection(
      int userId, Function(String err, FriendshipEntity? friendshipEntity) onNotificationReceived);

  /// Closes the current connection to stop receiving friendship notifications.
  ///
  /// This method ends the notification stream and stops the system from sending any future
  /// notifications related to friendship requests or updates.
  ///
  /// - Returns: None.
  void closeNotificationsConnection();

  /// Declines a pending friendship request.
  ///
  /// This method allows the user to decline a pending friendship request by providing the request's ID.
  ///
  /// - Parameters:
  ///   - [requestId]: The unique identifier for the friendship request to decline.
  ///
  /// - Returns: A [Future<bool>] that resolves to `true` if the request was successfully declined,
  ///   or `false` if the operation failed.
  Future<bool> declineFriendshipRequest(int requestId);

  /// Sends a friendship request to a user.
  ///
  /// This method sends a request to another user, asking them to become friends.
  ///
  /// - Parameters:
  ///   - [receiverId]: The unique identifier of the user to whom the friendship request will be sent.
  ///
  /// - Returns: A [Future<bool>] that resolves to `true` if the request was successfully sent,
  ///   or `false` if the operation failed.
  Future<bool> sendFriendRequest({required int receiverId});

  /// Accepts a pending friendship request.
  ///
  /// This method allows the user to accept a pending friendship request, establishing the friendship.
  ///
  /// - Parameters:
  ///   - [requestId]: The unique identifier for the friendship request to accept.
  ///
  /// - Returns: A [Future<bool>] that resolves to `true` if the request was successfully accepted,
  ///   or `false` if the operation failed.
  Future<bool> acceptFriendRequest(int requestId);
}
