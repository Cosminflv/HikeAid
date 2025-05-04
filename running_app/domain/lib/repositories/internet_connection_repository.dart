import '../entities/connectivity_status.dart';

abstract class InternetConnectionRepository {
  Future<DConnectivityStatus> get internetConnectionStatus;

  void registerOnConnectioStatusUpdated(Function(DConnectivityStatus status) onConnectivityChangedCallback);

  void unregister();
}
