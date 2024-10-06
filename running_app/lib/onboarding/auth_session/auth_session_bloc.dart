import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_events.dart';
import 'package:running_app/onboarding/auth_session/auth_session_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  AuthSessionBloc() : super(AuthSessionNotExistingState()) {
    on<AuthSessionUpdatedEvent>(_handleAuthSessionUpdated);

    on<LogoutEvent>(_handleLogout);
  }

  _handleAuthSessionUpdated(AuthSessionUpdatedEvent event, Emitter<AuthSessionState> emit) {
    if (event.session != null) {
      emit(AuthSessionExistingState(event.session!));
    } else {
      emit(AuthSessionNotExistingState());
    }
  }

  _handleLogout(LogoutEvent event, Emitter<AuthSessionState> emit) async {
    emit(AuthSessionNotExistingState());
  }
}
