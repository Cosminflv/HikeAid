import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domain/repositories/internet_connection_repository.dart';
import 'package:domain/entities/connectivity_status.dart';

import '../utils/debouncer.dart';

import 'dart:async';

class InternetConnectionRepositoryImpl extends InternetConnectionRepository {
  final _debouncer = Debouncer(milliseconds: 1000);

  StreamSubscription? subscription;

  @override
  Future<DConnectivityStatus> get internetConnectionStatus async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult.first.toStatus;
  }

  @override
  Future<bool> isConnected() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.ethernet);
  }

  @override
  void registerOnConnectioStatusUpdated(void Function(DConnectivityStatus status) onConnectivityChangedCallback) {
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (subscription == null || result.isEmpty) return;
      onConnectivityChangedCallback(result.first.toStatus);
    });
  }
  
  @override
  void unregister() {
    // TODO: implement unregister
  }
}

extension ConnectivityResultExtension on ConnectivityResult {
  DConnectivityStatus get toStatus {
    switch (this) {
      case ConnectivityResult.mobile:
        return DConnectivityStatus.mobile;
      case ConnectivityResult.wifi:
        return DConnectivityStatus.wifi;
      case ConnectivityResult.ethernet:
        return DConnectivityStatus.ethernet;
      case ConnectivityResult.vpn:
        return DConnectivityStatus.vpn;
      case ConnectivityResult.bluetooth:
        return DConnectivityStatus.bluetooth;
      case ConnectivityResult.other:
        return DConnectivityStatus.other;
      case ConnectivityResult.none:
        return DConnectivityStatus.none;
    }
  }
}
