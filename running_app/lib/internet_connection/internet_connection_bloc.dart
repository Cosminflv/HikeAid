import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/internet_connection_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/internet_connection/internet_connection_events.dart';

class InternetConnectionBloc extends Bloc<InternetConnectionEvent, bool> {
  final _usecase = sl.get<InternetConnectionUseCase>();
  InternetConnectionBloc() : super(true) {
    on<CheckInternetConnectionEvent>(_handleCheckInternetConnection);
    on<SetConnectionStatusEvent>(_handleSetConnectionStatus);
  }

  _handleCheckInternetConnection(CheckInternetConnectionEvent event, Emitter<bool> emit) async {
    final isConnected = await _usecase.isConnected();
    emit(isConnected);

    _usecase.registerOnConnectioStatusUpdated((isConnected) => add(SetConnectionStatusEvent(isConnected)));
  }

  _handleSetConnectionStatus(SetConnectionStatusEvent event, Emitter<bool> emit) => emit(event.value);
}
