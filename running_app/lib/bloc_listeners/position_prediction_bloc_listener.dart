import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/position_prediction/position_prediction_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_state.dart';

class PositionPredictionBlocListener extends StatelessWidget {
  final Widget child;

  const PositionPredictionBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<PositionPredictionBloc, PositionPredictionState>(
          listenWhen: (previous, current) =>
              previous.importedGPXPath != current.importedGPXPath && current.importedGPXPath != null,
          listener: (context, positionPredictionState) {
            final mapBloc = AppBlocs.mapBloc;

            mapBloc.add(PresentPathEvent(
              path: positionPredictionState.importedGPXPath!,
            ));
          }),
    ], child: child);
  }
}
