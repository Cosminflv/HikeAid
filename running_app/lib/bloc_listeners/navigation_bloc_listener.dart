import 'package:core/di/app_blocs.dart';
import 'package:domain/repositories/navigation_repository.dart';
import 'package:domain/use_cases/routing_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/navigation/navigation_view_bloc.dart';
import 'package:running_app/navigation/navigation_view_events.dart';
import 'package:running_app/navigation/navigation_view_state.dart';
import 'package:running_app/navigation_instructions/navigation_instructions_panel_event.dart';
import 'package:running_app/routing/routing_view_events.dart';
import 'package:running_app/shared_widgets/bottom_sheets/route_actions_bottom_sheet.dart';

class NavigationBlocListener extends StatelessWidget {
  final Widget child;

  const NavigationBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<NavigationViewBloc, NavigationViewState>(
          listenWhen: (previous, current) => previous.traveledDistance != current.traveledDistance,
          listener: (context, navigationState) {
            AppBlocs.navigationInstructionBloc.add(TraveledDistanceUpdatedEvent(navigationState.traveledDistance));
          }),
      // BlocListener<NavigationViewBloc, NavigationViewState>(
      //     listenWhen: (previous, current) => previous.previousCoordinates.length != current.previousCoordinates.length,
      //     listener: (context, navigationState) {
      //       if (AppBlocs.appBloc.state.isNavigating) {
      //         AppBlocs.mapBloc.add(AddPolylineMarkerEvent(navigationState.previousCoordinates));
      //       }
      //     }),
      // BlocListener<NavigationViewBloc, NavigationViewState>(
      //     listenWhen: (previous, current) => previous.status != current.status,
      //     listener: (context, navigationState) {
      //       switch (navigationState.status) {
      //         case NavigationStatus.started:
      //           if (!navigationState.isNavigatingOnTour) {
      //             AppBlocs.tourRecordingBloc.add(StartRecordingEvent(recordGpx: true));
      //           }
      //           break;
      //         case NavigationStatus.stopped:
      //         case NavigationStatus.finished:
      //           AppBlocs.tourRecordingBloc.add(StopRecordingEvent());
      //           break;
      //         case NavigationStatus.restarting:
      //         case NavigationStatus.paused:
      //           AppBlocs.tourRecordingBloc.add(PauseRecordingEvent());
      //           break;
      //       }
      //     }),
      BlocListener<NavigationViewBloc, NavigationViewState>(
          listener: (context, navigationState) {
            if (navigationState.status == NavigationStatus.started) {
              AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.navigation));

              AppBlocs.mapBloc.add(RemoveRoutesExceptMainEvent());
              AppBlocs.mapBloc.add(FollowPositionEvent(shouldTiltCamera: false, shouldZoomCamera: true));

              AppBlocs.routingBloc.add(CancelBuildRouteEvent());

              //final waypoints = AppBlocs.routePlanningBloc.state.waypoints;
              //final landmarks = waypoints.where((e) => e.landmark != null).map((e) => e.landmark!).toList();

              // final currentLocation = AppBlocs.locationBloc.state.currentPositionLandmark;
              // final distance = AppBlocs.mapBloc.state.mapSelectedRoute!.distanceToRoute(currentLocation!.coordinates);

              // for (final lmk in landmarks) {
              //   AppBlocs.mapBloc.add(PresentHighlightEvent(landmark: lmk, screenPosition: null, showLabel: false));
              // }

              // if (distance >= 50 && !navigationState.isSimulated) {
              //   NavigationAdjustRouteBottomSheet.show(context);
              // }

              SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                systemNavigationBarContrastEnforced: true,
                systemNavigationBarIconBrightness: Brightness.light,
              ));
            } else if (navigationState.status == NavigationStatus.finished) {
              // navigation finished
              // if (!navigationState.isNavigatingOnTour) {
              //   AppBlocs.tourRecordingBloc.add(StopRecordingEvent());
              // }
              AppBlocs.routingBloc.add(ResetEvent());
              AppBlocs.mapBloc
                ..add(RemoveAllRoutesEvent())
                ..add(RemoveAllHighlightsEvent());
              AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.initializedMap));
              //AppBlocs.routePlanningBloc.add(ResetRoutePlanningEvent());
            } else if (navigationState.status == NavigationStatus.stopped) {
              // navigation stopped or stopped for recalculation with new waypoint

              // if (!navigationState.isNavigatingOnTour) {
              //   AppBlocs.tourRecordingBloc.add(StopRecordingEvent());
              // }
              AppBlocs.routingBloc.add(ResetEvent());
              AppBlocs.mapBloc
                ..add(RemoveAllRoutesEvent())
                ..add(RemoveAllHighlightsEvent());
              AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.initializedMap));
              //AppBlocs.routePlanningBloc.add(ResetRoutePlanningEvent());
            } else if (navigationState.status == NavigationStatus.paused) {
              AppBlocs.navigationBloc.add(StopNavigationEvent());
              AppBlocs.routingBloc.add(RouteBuildStatusUpdatedEvent(RouteBuildStatus.succes));
              if (!RouteActionsBottomSheet.isOpened && AppBlocs.mapBloc.state.mapSelectedLandmark == null) {
                RouteActionsBottomSheet.show(context);
              }
            } else if (navigationState.status == NavigationStatus.restarting) {
              AppBlocs.navigationBloc.add(StopNavigationEvent());
              Future.delayed(Durations.medium3).then((value) {
                if (AppBlocs.mapBloc.state.mapSelectedRoute == null) return;
                AppBlocs.navigationBloc.add(StartNavigationEvent(AppBlocs.mapBloc.state.mapSelectedRoute!, null));
              });
            }
          },
          listenWhen: (previous, current) => previous.status != current.status),
    ], child: child);
  }
}
