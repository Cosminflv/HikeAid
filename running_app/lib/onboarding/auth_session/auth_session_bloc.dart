import 'package:core/di/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_events.dart';
import 'package:running_app/onboarding/auth_session/auth_session_state.dart';
import 'package:domain/use_cases/authentication_session_use_case.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  final authSessionUseCase = sl.get<AuthenticationSessionUseCase>();
  AuthSessionBloc() : super(AuthSessionNotExistingState()) {
    on<AuthSessionUpdatedEvent>(_handleAuthSessionUpdated);
    on<CheckForSessionEvent>(_handleCheckForSessionEvent);

    on<LogoutEvent>(_handleLogout);
  }

  _handleAuthSessionUpdated(AuthSessionUpdatedEvent event, Emitter<AuthSessionState> emit) {
    if (event.session != null) {
      emit(AuthSessionExistingState(event.session!));
    } else {
      emit(AuthSessionNotExistingState());
    }
  }

  _handleCheckForSessionEvent(CheckForSessionEvent event, Emitter<AuthSessionState> emit) async {
  final result = await authSessionUseCase.checkForSession();

    if (result != null) {
      emit(AuthSessionExistingState(result));
    } else {
      emit(AuthSessionNotExistingState());
    }
  }

  _handleLogout(LogoutEvent event, Emitter<AuthSessionState> emit) async {
    await authSessionUseCase.signOut();
    emit(AuthSessionNotExistingState());
  }
}
