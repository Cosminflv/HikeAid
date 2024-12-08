import 'package:domain/entities/friendship_entity.dart';
import 'package:equatable/equatable.dart';

class FriendshipsViewState extends Equatable {
  final List<FriendshipEntity> incomingRequests;

  const FriendshipsViewState({this.incomingRequests = const []});

  FriendshipsViewState copyWith({List<FriendshipEntity>? incomingRequests}) =>
      FriendshipsViewState(incomingRequests: incomingRequests ?? this.incomingRequests);

  @override
  List<Object?> get props => [incomingRequests];
}
