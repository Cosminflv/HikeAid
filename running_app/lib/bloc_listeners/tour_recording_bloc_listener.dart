import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/tour_recording/tour_recording_bloc.dart';
import 'package:running_app/tour_recording/tour_recording_state.dart';

class TourRecordingBlocListener extends StatelessWidget {
  final Widget child;

  const TourRecordingBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<TourRecordingBloc, TourRecordingState>(
        bloc: AppBlocs.tourRecordingBloc,
        listener: (context, tourRecordingState) {
          if (AppBlocs.appBloc.state.isRecording) {
            final tourRecordingCoordinates =
                tourRecordingState.recordedCoordinates.map((coordinate) => coordinate.latLng).toList();
            AppBlocs.mapBloc.add(AddPolylineMarkerEvent(tourRecordingCoordinates));
          }
        },
        listenWhen: (previous, current) => previous.recordedCoordinates.length != current.recordedCoordinates.length,
      ),
      BlocListener<TourRecordingBloc, TourRecordingState>(
        bloc: AppBlocs.tourRecordingBloc,
        listener: (context, state) {
          if (state.distanceTraveled == null || state.distanceTraveled! < 100) return;
          Navigator.of(context).pushNamed(RouteNames.tourFinished);
        },
        listenWhen: (previous, current) =>
            previous.status != RecordingStatus.disabled &&
            current.status == RecordingStatus.disabled &&
            current.isValidTour,
      ),
    ], child: child);
  }
}
