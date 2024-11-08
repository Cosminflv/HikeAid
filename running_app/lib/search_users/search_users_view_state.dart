import 'package:domain/use_cases/search_users_use_case.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:equatable/equatable.dart';

class SearchUsersState extends Equatable {
  final List<SearchUserEntity> results;
  final SearchStatus status;
  final SearchUserEntity? selectedUser;

  const SearchUsersState({this.results = const [], this.selectedUser, this.status = SearchStatus.none});

  SearchUsersState copyWith({
    List<SearchUserEntity>? results,
    SearchStatus? status,
    SearchUserEntity? selectedUser,
  }) =>
      SearchUsersState(
        results: results ?? this.results,
        status: status ?? this.status,
        selectedUser: selectedUser ?? this.selectedUser,
      );

  SearchUsersState copyWithNullSelectedLandmark() => SearchUsersState(
        results: results,
        status: status,
        selectedUser: null,
      );

  @override
  List<Object?> get props => [results, status, selectedUser];
}
