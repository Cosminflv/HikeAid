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
        listener: (context, locationState) {
          if (AppBlocs.appBloc.state.isRecording) {
            AppBlocs.mapBloc.add(AddPolylineMarkerEvent(locationState.recordedCoordinates));
          }
        },
        listenWhen: (previous, current) => previous.recordedCoordinates.length != current.recordedCoordinates.length,
      ),
      // BlocListener<TourRecordingBloc, TourRecordingState>(
      //   bloc: AppBlocs.tourRecordingBloc,
      //   listener: (context, state) {
      //     if (state.distanceTraveled == null || state.distanceTraveled! < 100) return;
      //     Navigator.of(context).pushNamed(RouteNames.tourFinished);
      //   },
      //   listenWhen: (previous, current) =>
      //       previous.status != RecordingStatus.disabled &&
      //       current.status == RecordingStatus.disabled &&
      //       current.isValidTour,
      // ),
      // BlocListener<TourRecordingBloc, TourRecordingState>(
      //   bloc: AppBlocs.tourRecordingBloc,
      //   listener: (context, state) => AppBlocs.toursViewBloc.add(AddCompletedTourEvent(tour: state.tour!)),
      //   listenWhen: (previous, current) =>
      //       previous.status != RecordingStatus.tourSaved && current.status == RecordingStatus.tourSaved,
      // )
    ], child: child);
  }
}
