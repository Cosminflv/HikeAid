import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_view_events.dart';
import 'home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewBloc() : super(const HomeViewState()) {
    on<SetCurrentHomeViewEvent>(_handleSetCurrentHomeViewEvent);
  }
  _handleSetCurrentHomeViewEvent(SetCurrentHomeViewEvent event, Emitter<HomeViewState> emit) =>
      emit(HomeViewState(type: event.type));
}
