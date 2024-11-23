import 'package:running_app/home/home_view_state.dart';

abstract class HomeViewEvent {}

class SetCurrentHomeViewEvent extends HomeViewEvent {
  final HomePageType type;

  SetCurrentHomeViewEvent(this.type);
}
