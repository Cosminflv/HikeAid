/// A repository interface for managing and monitoring the internet connection status.
///
/// The [InternetConnectionRepository] provides methods to check the current connection status
/// and register a callback to be notified when the connection status is updated.
abstract class InternetConnectionRepository {
  /// Checks if the device is currently connected to the internet.
  ///
  /// This method asynchronously checks the current internet connection status and returns a
  /// boolean value indicating whether the device is connected (`true`) or not (`false`).
  ///
  /// - Returns: A [Future<bool>] that resolves to `true` if the device is connected to the internet,
  ///   or `false` if there is no active internet connection.
  Future<bool> isConnected();

  /// Registers a callback to be notified when the internet connection status changes.
  ///
  /// This method allows the app to listen for changes in the internet connection status and
  /// react accordingly. The provided callback function will be invoked with a boolean argument
  /// representing the new connection status (`true` for connected, `false` for disconnected).
  ///
  /// - Parameters:
  ///   - [onConnectionUpdated]: A callback function to be invoked when the connection status changes.
  ///     The callback receives a [bool] indicating whether the device is connected to the internet.
  void registerOnConnectioStatusUpdated(Function(bool isConnected) onConnectionUpdated);
}
