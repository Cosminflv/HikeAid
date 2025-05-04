import 'package:equatable/equatable.dart';

enum HomePageType { map, record, profile, settings }

class HomeViewState extends Equatable {
  final HomePageType type;

  const HomeViewState({this.type = HomePageType.map});

  @override
  List<Object?> get props => [type];
}
