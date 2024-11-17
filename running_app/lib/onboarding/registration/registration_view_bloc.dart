import 'package:core/di/injection_container.dart';
import 'package:domain/entities/registration_status.dart';
import 'package:domain/use_cases/authentication_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/onboarding/registration/registration_view_event.dart';
import 'package:running_app/onboarding/registration/registration_view_state.dart';

class RegistrationViewBloc extends Bloc<RegistrationViewEvent, RegistrationViewState> {
  final authUsecase = sl.get<OnboardingUseCase>();

  RegistrationViewBloc() : super(const InitialRegistrationState()) {
    on<PerformRegistrationEvent>(_performRegistrationEventHandler);

    on<RegistrationLoadingEvent>(_registrationLoadingEventHandler);
    on<RegistrationSuccesfulEvent>(_registrationSuccesfulEventHandler);
    on<RegistrationFailedEvent>(_registrationFailedEventHandler);

    on<UpdateUsernameValueEvent>(_updateUsernameValueEvent);
    on<UpdateFirstNameValueEvent>(_updateFirstNameValueEvent);
    on<UpdateLastNameValueEvent>(_updateLastNameValueEvent);
    on<UpdatePasswordValueEvent>(_updatePasswordValueEvent);

    on<CompleteUserProfileEvent>(_handleCompleteUserProfileEvent);

    on<ClearRegistrationEvent>(_clearRegistrationEventHandler);
  }

  _performRegistrationEventHandler(PerformRegistrationEvent event, Emitter<RegistrationViewState> emit) {
    authUsecase.register(
        username: state.username,
        password: state.password,
        firstName: state.firstName,
        lastName: state.lastName,
        city: state.city,
        country: state.country,
        weight: state.weight,
        gender: state.gender,
        birthdate: event.birthdate,
        onProgress: (status) => _onRegistrationProgress(registrationStatus: status));
  }

  _registrationSuccesfulEventHandler(RegistrationSuccesfulEvent event, Emitter<RegistrationViewState> emit) async =>
      emit(const RegistrationSuccesfulState());

  _registrationFailedEventHandler(RegistrationFailedEvent event, Emitter<RegistrationViewState> emit) async =>
      emit(RegistrationFailedState(reason: event.reason));

  _registrationLoadingEventHandler(RegistrationLoadingEvent event, Emitter<RegistrationViewState> emit) =>
      RegistrationLoadingState(
          username: state.username, password: state.password, firstName: state.firstName, lastName: state.lastName);

  _handleCompleteUserProfileEvent(CompleteUserProfileEvent event, Emitter<RegistrationViewState> emit) {
    final initialState = state as InitialRegistrationState;

    emit(initialState.copyWith(city: event.city, country: event.country, weight: event.weight, gender: event.gender));
  }

  _clearRegistrationEventHandler(ClearRegistrationEvent event, Emitter<RegistrationViewState> emit) {
    emit(const InitialRegistrationState());
  }

  _updateUsernameValueEvent(UpdateUsernameValueEvent event, Emitter<RegistrationViewState> emit) {
    final initialState = state as InitialRegistrationState;

    emit(initialState.copyWith(username: event.value));
  }

  _updateFirstNameValueEvent(UpdateFirstNameValueEvent event, Emitter<RegistrationViewState> emit) {
    final initState = state as InitialRegistrationState;

    emit(initState.copyWith(firstName: event.value));
  }

  _updateLastNameValueEvent(UpdateLastNameValueEvent event, Emitter<RegistrationViewState> emit) {
    final initalState = state as InitialRegistrationState;

    emit(initalState.copyWith(lastName: event.value));
  }

  _updatePasswordValueEvent(UpdatePasswordValueEvent event, Emitter<RegistrationViewState> emit) {
    final initalState = state as InitialRegistrationState;

    emit(initalState.copyWith(password: event.value));
  }

  _onRegistrationProgress({required RegistrationStatus registrationStatus}) {
    switch (registrationStatus.runtimeType) {
      case const (RegistrationStarted):
        return;
      case const (RegistrationInProgress):
        add(RegistrationLoadingEvent());
        return;
      case const (RegistrationSuccesfulStatus):
        add(RegistrationSuccesfulEvent());

      case const (RegistrationFailed):
        registrationStatus as RegistrationFailed;
        add(RegistrationFailedEvent(reason: registrationStatus.reason));
    }
  }
}
