abstract class InternetConnectionEvent {}

class CheckInternetConnectionEvent extends InternetConnectionEvent {}

class SetConnectionStatusEvent extends InternetConnectionEvent {
  final bool value;

  SetConnectionStatusEvent(this.value);
}
