import 'package:core/di/injection_container.dart';
import 'package:domain/entities/authentication_status.dart';
import 'package:domain/use_cases/authentication_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_event.dart';
import 'package:running_app/onboarding/authentication/authentication_view_state.dart';

class AuthenticationViewBloc extends Bloc<AuthenticationViewEvent, AuthenticationViewState> {
  final authUsecase = sl.get<OnboardingUseCase>();

  AuthenticationViewBloc() : super(const InitialAuthenticationState()) {
    on<PerformAuthenticationEvent>(_authenticateEventHandler);

    on<AuthenticationSuccesfulEvent>(_handleAuthenticationSuccesful);
    on<AuthenticationLoadingEvent>(_handleAuthenticationLoading);
    on<AuthenticationFailedEvent>(_handleAuthenticationFailed);

    on<UpdateUsernameValueEvent>(_handleUpdateLoginEmailValue);
    on<UpdatePasswordValueEvent>(_handleUpdateLoginPasswordValue);

    on<AuthResetEvent>(_authResetEventHandler);
    on<AuthClearEvent>(_authClearEventHandler);
  }

  _authenticateEventHandler(PerformAuthenticationEvent event, Emitter<AuthenticationViewState> emit) async {
    authUsecase.authenticate(
        username: state.username, password: state.password, onProgress: (state) => _onAuthProgress(authStatus: state));
  }

  _handleAuthenticationSuccesful(AuthenticationSuccesfulEvent event, Emitter<AuthenticationViewState> emit) async =>
      emit(AuthenticationSuccesfulState(session: event.session));

  _handleAuthenticationLoading(AuthenticationLoadingEvent event, Emitter<AuthenticationViewState> emit) =>
      emit(AuthenticationLoadingState(
        username: state.username,
        password: state.password,
      ));

  _handleAuthenticationFailed(AuthenticationFailedEvent event, Emitter<AuthenticationViewState> emit) {
    emit(AuthenticationFailedState(
      reason: event.reason,
      username: state.username,
      password: state.password,
    ));
  }

  _authResetEventHandler(AuthResetEvent event, Emitter<AuthenticationViewState> emit) {
    emit(InitialAuthenticationState(
      username: state.username,
      password: state.password,
    ));
  }

  _authClearEventHandler(AuthClearEvent event, Emitter<AuthenticationViewState> emit) {
    emit(const InitialAuthenticationState());
  }

  _handleUpdateLoginEmailValue(UpdateUsernameValueEvent event, Emitter<AuthenticationViewState> emit) {
    final initialState = state as InitialAuthenticationState;

    emit(initialState.copyWith(username: event.value));
  }

  _handleUpdateLoginPasswordValue(UpdatePasswordValueEvent event, Emitter<AuthenticationViewState> emit) {
    if (state is! InitialAuthenticationState) return;
    final initialState = state as InitialAuthenticationState;

    emit(initialState.copyWith(password: event.value));
  }

  _onAuthProgress({required AuthenticationStatus authStatus}) async {
    switch (authStatus.runtimeType) {
      case AuthenticationStarted:
        return;
      case AuthenticationSuccesful:
        authStatus as AuthenticationSuccesful;
        add(AuthenticationSuccesfulEvent(session: authStatus.session));
        return;
      case AuthenticationInProgress:
        add(AuthenticationLoadingEvent());

        return;
      case AuthenticationFailed:
        authStatus as AuthenticationFailed;

        add(AuthenticationFailedEvent(
          reason: authStatus.reason,
        ));

        return;
    }
  }
}
