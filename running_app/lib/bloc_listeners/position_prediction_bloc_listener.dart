import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/position_prediction/position_prediction_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_state.dart';
import 'package:running_app/routing/routing_view_events.dart';
import 'package:running_app/shared_widgets/dialogs/start_simulation_dialog.dart';
import 'package:shared/domain/landmark_entity.dart';

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
      BlocListener<PositionPredictionBloc, PositionPredictionState>(
          listenWhen: (previous, current) => previous.predictedPositions != current.predictedPositions,
          listener: (context, positionPredictionState) {
            final mapBloc = sl<MapViewBloc>(instanceName: 'userHike');
            final predictedPositions = positionPredictionState.predictedPositions;

            final presentedHike = mapBloc.state.routes.first;
            final List<LandmarkEntity> predictedLmks = [];

            for (final dist in predictedPositions) {
              final lmk = presentedHike.getLandmarkAtDistance(dist.toInt());
              if (lmk == null) continue;
              predictedLmks.add(presentedHike.getLandmarkAtDistance(dist.toInt())!);
            }

            mapBloc.add(PresentHighlightsEvent(landmarks: predictedLmks));
          })
    ], child: child);
  }
}
