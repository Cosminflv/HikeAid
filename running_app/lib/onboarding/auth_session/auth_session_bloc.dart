import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/authentication_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/auth_session/auth_session_events.dart';
import 'package:running_app/onboarding/auth_session/auth_session_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  late OnboardingUseCase _onboardingUseCase;

  AuthSessionBloc() : super(AuthSessionNotExistingState()) {
    _onboardingUseCase = sl.get<OnboardingUseCase>();
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
    final success = await _onboardingUseCase.logout();
    if (success == null) {
      emit(AuthSessionNotExistingState());
    } else {
      final currentSession = (state as AuthSessionExistingState).session;
      emit(AuthSessionFailureState(success));
      emit(AuthSessionExistingState(currentSession));
    }
  }
}
