import 'package:domain/entities/connectivity_status.dart';
import 'package:equatable/equatable.dart';

class DeviceInfoState extends Equatable {
  final DConnectivityStatus connectivityStatus;
  final int batteryPercentage;

  const DeviceInfoState({
    this.connectivityStatus = DConnectivityStatus.none,
    this.batteryPercentage = 100,
  });

  bool get hasInternetConnection => connectivityStatus.isConnected();

  DeviceInfoState copyWith({DConnectivityStatus? connectivityStatus, int? batteryPercentage}) => DeviceInfoState(
        connectivityStatus: connectivityStatus ?? this.connectivityStatus,
        batteryPercentage: batteryPercentage ?? this.batteryPercentage,
      );

  @override
  List<Object?> get props => [
        connectivityStatus,
        batteryPercentage,
      ];
}
