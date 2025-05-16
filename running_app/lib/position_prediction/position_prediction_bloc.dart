import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_events.dart';
import 'package:running_app/position_prediction/position_prediction_state.dart';
import 'package:domain/use_cases/position_prediction_use_case.dart';

class PositionPredictionBloc extends Bloc<PositionPredictionEvent, PositionPredictionState> {
  final PositionPredictionUseCase _positionPredictionUseCase;

  PositionPredictionBloc(this._positionPredictionUseCase) : super(const PositionPredictionState()) {
    on<ImportGPXDemoEvent>(_handleImportGPXDemo);
    on<ConfirmHikeEvent>(_handleConfirmHike);
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
}
