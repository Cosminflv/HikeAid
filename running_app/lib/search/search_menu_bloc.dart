import 'package:core/di/injection_container.dart';
import 'package:domain/entities/search_action_type_entity.dart';
import 'package:domain/repositories/search_repository.dart';
import 'package:domain/use_cases/search_use_case.dart';
import 'package:domain/entities/search_status.dart';
import 'package:running_app/search/search_menu_events.dart';
import 'package:running_app/search/search_menu_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

class SearchMenuBloc extends Bloc<SearchMenuEvent, SearchMenuState> {
  final _searchUseCase = sl.get<SearchUseCase>();
  final DSearchType type;

  SearchMenuBloc({this.type = DSearchType.aroundPosition}) : super(const SearchMenuState()) {
    on<SearchTextEvent>(_handleSearchText);

    on<SearchSuccessfulEvent>(_handleSearchSuccessful);
    on<SearchStatusUpdatedEvent>(_handleSearchStatusUpdated);
    on<ClearSearchEvent>(_handleClearSearch);
    on<ResultSelectedEvent>(_handleResultSelected);
  }

  _handleSearchText(SearchTextEvent event, Emitter<SearchMenuState> emit) {
    if (event.text.isEmpty) {
      _searchUseCase.clear();
      add(SearchStatusUpdatedEvent(SearchStatus.none));
      return;
    }

    add(SearchStatusUpdatedEvent(SearchStatus.started));

    _searchUseCase.search(text: event.text, referenceCoordinates: event.coordinates, onResult: _onSearchCompleted);
  }

  _handleClearSearch(ClearSearchEvent event, Emitter<SearchMenuState> emit) {
    _searchUseCase.clear();
    emit(state.copyWith(results: [], status: SearchStatus.none));
  }

  _handleSearchSuccessful(SearchSuccessfulEvent event, Emitter<SearchMenuState> emit) =>
      emit(state.copyWith(results: event.results));

  _handleSearchStatusUpdated(SearchStatusUpdatedEvent event, Emitter<SearchMenuState> emit) =>
      emit(state.copyWith(status: event.status));

  _handleResultSelected(ResultSelectedEvent event, Emitter<SearchMenuState> emit) {
    if (event.result != null) {
      emit(state.copyWith(selectedLandmark: event.result));
    } else {
      emit(state.copyWithNullSelectedLandmark());
    }
  }

  _onSearchCompleted(SearchResult result) {
    if (isClosed) return;
    if (result is Left) return;

    add(SearchStatusUpdatedEvent(SearchStatus.ended));
    add(SearchSuccessfulEvent((result as Right).value));
  }
}
