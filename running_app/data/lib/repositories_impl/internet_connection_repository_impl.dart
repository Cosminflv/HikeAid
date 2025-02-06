import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domain/repositories/internet_connection_repository.dart';

import '../utils/debouncer.dart';
import 'dart:async';

class InternetConnectionRepositoryImpl extends InternetConnectionRepository {
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  Future<bool> isConnected() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.ethernet);
  }

  @override
  void registerOnConnectioStatusUpdated(Function(bool isConnected) onConnectionUpdated) {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> connectivityResult) {
      final isConnected = connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet);

      _debouncer.run(() {
        onConnectionUpdated(isConnected);
      });
    });
  }
}
