import 'package:domain/entities/connectivity_status.dart';
import 'package:domain/repositories/internet_connection_repository.dart';

class DeviceUseCase {
  final InternetConnectionRepository _connectivityRepository;

  DeviceUseCase(this._connectivityRepository);

  Future<DConnectivityStatus> get internetConnectionStatus => _connectivityRepository.internetConnectionStatus;

  void registerForConnectivityStatus(void Function(DConnectivityStatus status) onConnectivityChangedCallback) {
    _connectivityRepository.registerOnConnectioStatusUpdated(onConnectivityChangedCallback);
  }

  void unregister() {
    _connectivityRepository.unregister();
  }
}
