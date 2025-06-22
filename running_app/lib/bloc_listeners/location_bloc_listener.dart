import 'package:core/di/app_blocs.dart';
import 'package:domain/repositories/navigation_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/location/location_state.dart';
import 'package:running_app/map/map_view_event.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/navigation/navigation_view_events.dart';
import 'package:running_app/position_prediction/position_prediction_events.dart';
import 'package:running_app/tour_recording/tour_recording_events.dart';
import 'package:running_app/tour_recording/tour_recording_state.dart';
import 'package:shared/domain/tour_entity.dart';

class LocationBlocListener extends StatelessWidget {
  final Widget child;

  const LocationBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<LocationBloc, LocationState>(
        listener: (context, locationState) {
          if (locationState.openLocationPanel == true) {
            AppBlocs.mapBloc.add(SelectedLandmarkUpdatedEvent(
                landmark: null,
                forceCenter: true,
                coordinates: locationState.currentPosition?.coordinates,
                name: AppLocalizations.of(context)!.myPosition));
          }
        },
        listenWhen: (previous, current) => previous.currentPosition == null && current.currentPosition != null,
      ),
      BlocListener<LocationBloc, LocationState>(
        listener: (context, locationState) {
          final positionPredictionBloc = AppBlocs.positionPredictionBloc;
          final navigationBlocState = AppBlocs.navigationBloc.state;
          final recordingBlocState = AppBlocs.tourRecordingBloc.state;
          if (positionPredictionBloc.state.isPositionTransferEnabled &&
              (navigationBlocState.status == NavigationStatus.started ||
                  recordingBlocState.status == RecordingStatus.enabled)) {
            positionPredictionBloc.add(SendCoordinatesEvent(
                CoordinatesWithTimestamp(locationState.currentPosition!.coordinates, 0.0, 0, DateTime.now())));
          }

            AppBlocs.tourRecordingBloc.add(UpdatePositionEvent(locationState.currentPosition));
          
          if (AppBlocs.appBloc.state.isNavigating && locationState.currentPosition != null) {
            AppBlocs.navigationBloc.add(AddPreviousCoordinatesEvent(locationState.currentPosition!.coordinates));
          }
        },
        listenWhen: (previous, current) => previous.currentPosition != current.currentPosition,
      ),
    ], child: child);
  }
}
