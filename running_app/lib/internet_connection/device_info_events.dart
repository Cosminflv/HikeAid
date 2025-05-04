import 'package:domain/entities/connectivity_status.dart';

abstract class DeviceInfoEvent {}

class CheckInternetConnectionEvent extends DeviceInfoEvent {}

class SetConnectionStatusEvent extends DeviceInfoEvent {
  final DConnectivityStatus value;

  SetConnectionStatusEvent(this.value);
}

class BatteryPercentageChangedEvent extends DeviceInfoEvent {
  final int percentage;
  BatteryPercentageChangedEvent({required this.percentage});
}

class EnableKeepScreenAwakeEvent extends DeviceInfoEvent {}

class DisableKeepScreenAwakeEvent extends DeviceInfoEvent {}
