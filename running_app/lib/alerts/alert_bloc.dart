import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/alerts/alert_state.dart';
import 'package:domain/use_cases/alert_use_case.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final AlertUseCase _alertUseCase;

  AlertBloc(this._alertUseCase) : super(AlertState()) {
    on<FetchAlertsEvent>(_handleFetchAlerts);
    on<ConfirmAlertEvent>(_handleConfirmAlert);
  }

  _handleFetchAlerts(FetchAlertsEvent event, Emitter<AlertState> emit) async {
    final alerts = await _alertUseCase.getAlerts();
    emit(state.copyWith(alerts: alerts));
  }

  _handleConfirmAlert(ConfirmAlertEvent event, Emitter<AlertState> emit) async {
    // final result = await _alertUseCase.confirmAlert(event.alert);
    // emit(state.copyWith(isConfirmed: result));
  }
}
