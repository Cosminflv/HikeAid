import 'package:domain/entities/alert_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/alerts/alert_state.dart';
import 'package:domain/use_cases/alert_use_case.dart';
import 'package:domain/use_cases/pending_alerts_use_case.dart';

import 'package:running_app/internet_connection/internet_connection_bloc.dart';

import 'dart:async';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final AlertUseCase _alertUseCase;
  final InternetConnectionBloc _internetConnectionBloc;
  final PendingAlertsUseCase _pendingAlertsUseCase;
  final StreamController<List<AlertEntity>> _alertUpdates = StreamController.broadcast();

  AlertBloc(this._alertUseCase, this._internetConnectionBloc, this._pendingAlertsUseCase) : super(AlertState()) {
    _internetConnectionBloc.stream.listen((isConnected) {
      if (isConnected) add(RetryPendingAlertsEvent());
    });

    on<FetchAlertsEvent>(_handleFetchAlerts);
    on<ConfirmAlertEvent>(_handleConfirmAlert);
    on<InvalidateAlertEvent>(_handleInvalidateAlert);
    on<AddAlertEvent>(_handleAddAlert);

    on<RegisterAlertsSubscription>(_handleRegisterAlertsSubscription);
    on<CloseAlertsSubscription>(_handleCloseAlertsSubscription);

    on<ResetStateBooleansEvent>(_handleResetStateBooleans);

    on<AlertSelectedEvent>(_handleAlertSelected);
    on<AlertUnselectedEvent>(_handleAlertUnselected);

    on<RetryPendingAlertsEvent>(_handleRetryPendingAlerts);
  }

  _handleFetchAlerts(FetchAlertsEvent event, Emitter<AlertState> emit) async {
    final alerts = await _alertUseCase.getAlerts();
    emit(state.copyWith(alerts: alerts));
  }

  _handleAddAlert(AddAlertEvent event, Emitter<AlertState> emit) async {
    if (_internetConnectionBloc.state) {
      // Online: Send immediately
      final result = await _alertUseCase.addAlert(
        title: event.title,
        description: event.description,
        type: event.type,
        latitude: event.latitude,
        longitude: event.longitude,
        image: event.image,
      );
      emit(state.copyWith(isAdded: result));
    } else {
      // Offline: Save to pending
      await _pendingAlertsUseCase.savePendingAlert(
          event.title, event.description, event.type, event.latitude, event.longitude, event.image);
      emit(state.copyWith(hasPended: true));
    }
  }

  Future<void> _handleRetryPendingAlerts(RetryPendingAlertsEvent event, Emitter<AlertState> emit) async {
    final pendingAlerts = await _pendingAlertsUseCase.getPendingAlerts();
    print("BEFORE ADDING ALERT: ${pendingAlerts.length}\n");
    for (var alert in pendingAlerts) {
      final success = await _alertUseCase.addAlert(
          title: alert.title,
          description: alert.description,
          type: alert.type,
          latitude: alert.coordinates.latitude,
          longitude: alert.coordinates.longitude,
          image: alert.image);
      print("ADDED ALERT");
      if (success) await _pendingAlertsUseCase.deletePendingAlert(alert.id);
      emit(state.copyWith(isAdded: true));
    }
  }

  _handleConfirmAlert(ConfirmAlertEvent event, Emitter<AlertState> emit) async {
    final result = await _alertUseCase.confirmAlert(event.alertId);
    emit(state.copyWith(isConfirmed: result));
  }

  _handleInvalidateAlert(InvalidateAlertEvent event, Emitter<AlertState> emit) async {}

  _handleRegisterAlertsSubscription(RegisterAlertsSubscription event, Emitter<AlertState> emit) async {
    await _alertUseCase.registerAlertsCallback((alerts) {
      _alertUpdates.add(List<AlertEntity>.from(state.alerts)..addAll(alerts));
    });

    await emit.forEach<List<AlertEntity>>(_alertUpdates.stream, onData: (updatedAlerts) {
      return state.copyWith(alerts: updatedAlerts);
    });
  }

  _handleCloseAlertsSubscription(CloseAlertsSubscription event, Emitter<AlertState> emit) async {
    await _alertUseCase.unregisterAlertsCallback();
  }

  _handleResetStateBooleans(ResetStateBooleansEvent event, Emitter<AlertState> emit) async {
    emit(state.copyWith(isConfirmed: false, isAdded: false, hasPended: false));
  }

  _handleAlertSelected(AlertSelectedEvent event, Emitter<AlertState> emit) async {
    emit(state.copyWith(pickedAlert: event.pickedAlert));
  }

  _handleAlertUnselected(AlertUnselectedEvent event, Emitter<AlertState> emit) async {
    emit(state.copyWithNullAlert());
  }
}
