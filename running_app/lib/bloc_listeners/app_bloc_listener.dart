import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/routing/routing_view_events.dart';
import 'package:running_app/tour_recording/tour_recording_bloc.dart';
import 'package:running_app/tour_recording/tour_recording_events.dart';
import 'package:running_app/utils/sizes.dart';

class AppBlocListener extends StatelessWidget {
  final Widget child;
  const AppBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<AppBloc, AppState>(
        bloc: AppBlocs.appBloc,
        listener: (context, appState) {
          final mapBloc = AppBlocs.mapBloc;

          mapBloc.add(InitMapViewEvent(
            screenCenter: Sizes.screenCenter,
            mapVisibleAreaFunction: () => Sizes.getMapVisibleArea(context),
            centerOfVisibleAreaFunction: () => Sizes.getCenterOfVisibleArea(context),
          ));
        },
        listenWhen: (previous, current) =>
            previous.status == AppStatus.intializedSDK && current.status == AppStatus.initializedMap,
      ),
      BlocListener<AppBloc, AppState>(
        bloc: AppBlocs.appBloc,
        listener: (context, appState) {
          if (appState.isRecording) {
            AppBlocs.mapBloc 
              ..add(RemoveAllRoutesEvent())
              ..add(RemoveAllHighlightsEvent())
              ..add(SetIsMapInteractiveEvent(isMapInteractive: false));
            AppBlocs.routingBloc.add(CancelBuildRouteEvent());
          }

          if (!appState.isRecording) {
            AppBlocs.mapBloc
              ..add(ClearMarkersEvent())
              ..add(ClearPathsEvent())
              ..add(RemoveAllRoutesEvent())
              ..add(RemoveAllHighlightsEvent())
              ..add(SetIsMapInteractiveEvent(isMapInteractive: true));
          }

          if (!appState.isRecordingPaused) {
            sl
                .get<TourRecordingBloc>()
                .add(appState.isRecording ? StartRecordingEvent(recordGpx: true) : StopRecordingEvent());

            if (!appState.isRecording) {
              AppBlocs.tourRecordingBloc.add(SaveTourEvent());
            }
          }
        },
        listenWhen: (previous, current) => previous.isRecording != current.isRecording,
      ),
    ], child: child);
  }
}
