import 'package:domain/entities/alert_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/alerts/alert_state.dart';
import 'package:domain/use_cases/alert_use_case.dart';

import 'dart:async';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final AlertUseCase _alertUseCase;
  final StreamController<List<AlertEntity>> _alertUpdates = StreamController.broadcast();

  AlertBloc(this._alertUseCase) : super(AlertState()) {
    on<FetchAlertsEvent>(_handleFetchAlerts);
    on<ConfirmAlertEvent>(_handleConfirmAlert);
    on<InvalidateAlertEvent>(_handleInvalidateAlert);
    on<AddAlertEvent>(_handleAddAlert);
    on<RegisterAlertsSubscription>(_handleRegisterAlertsSubscription);

    on<ResetHasConfirmedEvent>(_handleResetHasAdded);

    on<AlertSelectedEvent>(_handleAlertSelected);
    on<AlertUnselectedEvent>(_handleAlertUnselected);
  }

  _handleFetchAlerts(FetchAlertsEvent event, Emitter<AlertState> emit) async {
    final alerts = await _alertUseCase.getAlerts();
    emit(state.copyWith(alerts: alerts));
  }

  _handleAddAlert(AddAlertEvent event, Emitter<AlertState> emit) async {
    final result = await _alertUseCase.addAlert(
        event.title, event.description, event.type, event.latitude, event.longitude, event.image);
    emit(state.copyWith(isAdded: result));
  }

  _handleConfirmAlert(ConfirmAlertEvent event, Emitter<AlertState> emit) async {
    final result = await _alertUseCase.confirmAlert(event.alertId);
    emit(state.copyWith(isConfirmed: result));
  }

  _handleInvalidateAlert(InvalidateAlertEvent event, Emitter<AlertState> emit) async {}

  _handleRegisterAlertsSubscription(RegisterAlertsSubscription event, Emitter<AlertState> emit) async {
    _alertUseCase.registerAlertsCallback((alerts) {
      _alertUpdates.add(List<AlertEntity>.from(state.alerts)..addAll(alerts));
    });

    await emit.forEach<List<AlertEntity>>(_alertUpdates.stream, onData: (updatedAlerts) {
      return state.copyWith(alerts: updatedAlerts);
    });
  }

  _handleResetHasAdded(ResetHasConfirmedEvent event, Emitter<AlertState> emit) async {
    emit(state.copyWith(isConfirmed: false));
  }

  _handleAlertSelected(AlertSelectedEvent event, Emitter<AlertState> emit) async {
    emit(state.copyWith(pickedAlert: event.pickedAlert));
  }

  _handleAlertUnselected(AlertUnselectedEvent event, Emitter<AlertState> emit) async {
    emit(state.copyWithNullAlert());
  }
}
