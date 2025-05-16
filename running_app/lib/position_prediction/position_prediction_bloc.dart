import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_events.dart';
import 'package:running_app/position_prediction/position_prediction_state.dart';
import 'package:domain/use_cases/position_prediction_use_case.dart';
import 'package:shared/domain/tour_entity.dart';

class PositionPredictionBloc extends Bloc<PositionPredictionEvent, PositionPredictionState> {
  final PositionPredictionUseCase _positionPredictionUseCase;
  Timer? _debounceTimer;
  CoordinatesWithTimestamp? _pendingCoordinates; // Track the latest pending coordinates

  PositionPredictionBloc(this._positionPredictionUseCase) : super(const PositionPredictionState()) {
    on<ImportGPXDemoEvent>(_handleImportGPXDemo);
    on<ConfirmHikeEvent>(_handleConfirmHike);

    on<ReisterPositionTransferEvent>(_handleRegisterPositionTransfer);
    on<UnregisterPositionTransferEvent>(_handleUnregisterPositionTransfer);

    on<SendCoordinatesEvent>(_handleSendCoordinates);
  }

  void _handleImportGPXDemo(ImportGPXDemoEvent event, Emitter<PositionPredictionState> emit) async {
    // Handle the import GPX demo event
    final path = await _positionPredictionUseCase.importGPXDemo(event.assetsFilePath);

    emit(state.copyWith(importedGPXPath: path));
  }

  void _handleConfirmHike(ConfirmHikeEvent event, Emitter<PositionPredictionState> emit) {
    if (event.hasConfirmedHike) {
      _positionPredictionUseCase.confirmHike(state.importedGPXPath!);
    }
    // Handle the confirm hike event
    emit(state.copyWith(hasConfirmedHike: event.hasConfirmedHike));
  }

  void _handleRegisterPositionTransfer(
      ReisterPositionTransferEvent event, Emitter<PositionPredictionState> emit) async {
    // Handle the register position transfer event
    await _positionPredictionUseCase.registerPositionTransfer(event.userId);
    emit(state.copyWith(isPositionTransferEnabled: true));
  }

  void _handleUnregisterPositionTransfer(UnregisterPositionTransferEvent event, Emitter<PositionPredictionState> emit) {
    // Handle the unregister position transfer event
    _positionPredictionUseCase.unregisterPositionTransfer();
    emit(state.copyWith(isPositionTransferEnabled: false));
  }

  void _handleSendCoordinates(SendCoordinatesEvent event, Emitter<PositionPredictionState> emit) {
    // If no timer is active, send immediately
    if (_debounceTimer == null || !_debounceTimer!.isActive) {
      _positionPredictionUseCase.sendCoordinates(event.coordinates);
    } else {
      // Update pending coordinates during the cooldown
      _pendingCoordinates = event.coordinates;
      return; // Exit early to avoid restarting the timer
    }

    // Start a 5-second cooldown
    _debounceTimer = Timer(const Duration(seconds: 5), () {
      if (_pendingCoordinates != null) {
        // Send the last pending coordinates after 5 seconds
        _positionPredictionUseCase.sendCoordinates(_pendingCoordinates!);
        _pendingCoordinates = null;
      }
      _debounceTimer = null; // Reset the timer
    });
  }
}
