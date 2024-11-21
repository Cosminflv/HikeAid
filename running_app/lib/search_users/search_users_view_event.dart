import 'package:domain/entities/search_status.dart';
import 'package:domain/entities/search_user_entity.dart';

abstract class SearchUsersEvent {}

class SearchUserEvent extends SearchUsersEvent {
  final String text;
  final int userId;

  SearchUserEvent({required this.text, required this.userId});
}

class SearchSuccessfulEvent extends SearchUsersEvent {
  final List<SearchUserEntity> results;

  SearchSuccessfulEvent(this.results);
}

class SearchStatusUpdatedEvent extends SearchUsersEvent {
  final SearchStatus status;

  SearchStatusUpdatedEvent(this.status);
}

class ResultSelectedEvent extends SearchUsersEvent {
  SearchUserEntity? result;

  ResultSelectedEvent({required this.result});
}

class ClearSearchEvent extends SearchUsersEvent {}

class AddFriendEvent extends SearchUsersEvent {
  final int requesterId;
  final int receiverId;

  AddFriendEvent({required this.requesterId, required this.receiverId});
}
