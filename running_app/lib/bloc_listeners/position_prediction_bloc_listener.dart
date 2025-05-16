import 'package:core/di/app_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/position_prediction/position_prediction_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_state.dart';
import 'package:running_app/routing/routing_view_events.dart';
import 'package:running_app/shared_widgets/dialogs/start_simulation_dialog.dart';

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

            showStartSimulationDialog(context);
          }),
      BlocListener<PositionPredictionBloc, PositionPredictionState>(
          listenWhen: (previous, current) => previous.hasConfirmedHike != current.hasConfirmedHike,
          listener: (context, positionPredictionState) {
            if (positionPredictionState.hasConfirmedHike) {
              AppBlocs.routingBloc.add(BuildRouteFromPathEvent(path: positionPredictionState.importedGPXPath!));
            }
          }),
    ], child: child);
  }
}
