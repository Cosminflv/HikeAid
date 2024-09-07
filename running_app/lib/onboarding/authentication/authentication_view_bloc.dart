import 'package:core/di/injection_container.dart';
import 'package:domain/entities/authrntication_status.dart';
import 'package:domain/use_cases/authentication_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/authentication/authentication_view_event.dart';
import 'package:running_app/onboarding/authentication/authentication_view_state.dart';

class AuthenticationViewBloc extends Bloc<AuthenticationViewEvent, AuthenticationViewState> {
  final authUsecase = sl.get<AuthenticationUseCase>();

  AuthenticationViewBloc() : super(const InitialAuthenticationState()) {
    on<PerformAuthenticationEvent>(_authenticateEventHandler);

    on<AuthenticationSuccesfulEvent>(_handleAuthenticationSuccesful);
    on<AuthenticationLoadingEvent>(_handleAuthenticationLoading);
    on<AuthenticationFailedEvent>(_handleAuthenticationFailed);

    on<UpdateLoginUsernameValueEvent>(_handleUpdateLoginEmailValue);
    on<UpdateLoginPasswordValueEvent>(_handleUpdateLoginPasswordValue);

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

  _handleUpdateLoginEmailValue(UpdateLoginUsernameValueEvent event, Emitter<AuthenticationViewState> emit) {
    final initialState = state as InitialAuthenticationState;

    emit(initialState.copyWith(username: event.value));
  }

  _handleUpdateLoginPasswordValue(UpdateLoginPasswordValueEvent event, Emitter<AuthenticationViewState> emit) {
    final initialState = state as InitialAuthenticationState;

    emit(initialState.copyWith(password: event.value));
  }

  _onAuthProgress({required AuthenticationStatus authStatus}) async {
    switch (authStatus.runtimeType) {
      case const (AuthenticationStarted):
        return;
      case const (AuthenticationSuccesful):
        authStatus as AuthenticationSuccesful;
        add(AuthenticationSuccesfulEvent(session: authStatus.session));
        return;
      case const (AuthenticationInProgress):
        add(AuthenticationLoadingEvent());

        return;
      case const (AuthenticationFailed):
        authStatus as AuthenticationFailed;

        add(AuthenticationFailedEvent(
          reason: authStatus.reason,
        ));

        return;
    }
  }
}
