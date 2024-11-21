abstract class InternetConnectionRepository {
  Future<bool> isConnected();

  void registerOnConnectioStatusUpdated(Function(bool isConnected) onConnectionUpdated);
}
