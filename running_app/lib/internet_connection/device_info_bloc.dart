import 'package:domain/use_cases/internet_connection_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/internet_connection/device_info_events.dart';
import 'package:running_app/internet_connection/device_info_state.dart';

class DeviceInfoBloc extends Bloc<DeviceInfoEvent, DeviceInfoState> {
  final DeviceUseCase _usecase;

  DeviceInfoBloc(this._usecase) : super(const DeviceInfoState()) {
    on<CheckInternetConnectionEvent>(_handleCheckInternetConnection);
    on<SetConnectionStatusEvent>(_handleSetConnectionStatus);
  }

  _handleCheckInternetConnection(CheckInternetConnectionEvent event, Emitter<DeviceInfoState> emit) async {
    final status = await _usecase.internetConnectionStatus;
    emit(state.copyWith(connectivityStatus: status));

    _usecase.registerForConnectivityStatus((isConnected) => add(SetConnectionStatusEvent(isConnected)));
  }

  _handleSetConnectionStatus(SetConnectionStatusEvent event, Emitter<DeviceInfoState> emit) =>
      emit(state.copyWith(connectivityStatus: event.value));
}
