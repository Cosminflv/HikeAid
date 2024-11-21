import 'package:domain/repositories/internet_connection_repository.dart';

class InternetConnectionUseCase {
  final InternetConnectionRepository _repository;

  InternetConnectionUseCase(this._repository);

  bool _hasRegistered = false;

  Future<bool> isConnected() => _repository.isConnected();

  void registerOnConnectioStatusUpdated(Function(bool isConnected) onConnectionUpdated) {
    if (!_hasRegistered) {
      _repository.registerOnConnectioStatusUpdated(onConnectionUpdated);
      _hasRegistered = true;
    }
  }
}
