import 'package:domain/entities/friendship_entity.dart';
import 'package:equatable/equatable.dart';

class FriendshipsViewState extends Equatable {
  final bool isInitialized;
  final List<FriendshipEntity> incomingRequests;

  const FriendshipsViewState({this.isInitialized = false, this.incomingRequests = const []});

  FriendshipsViewState copyWith({bool? isInitialized, List<FriendshipEntity>? incomingRequests}) =>
      FriendshipsViewState(
          isInitialized: isInitialized ?? this.isInitialized,
          incomingRequests: incomingRequests ?? this.incomingRequests);

  @override
  List<Object?> get props => [isInitialized, incomingRequests];
}
