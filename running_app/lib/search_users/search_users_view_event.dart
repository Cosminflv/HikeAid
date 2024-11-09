import 'package:domain/entities/search_user_entity.dart';
import 'package:domain/use_cases/search_users_use_case.dart';

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
