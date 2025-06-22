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
import 'package:running_app/position_prediction/position_prediction_events.dart';
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
      BlocListener<NavigationViewBloc, NavigationViewState>(
          listener: (context, navigationState) {
            if (navigationState.status == NavigationStatus.started) {
              AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.navigation));

              AppBlocs.mapBloc.add(RemoveRoutesExceptMainEvent());
              AppBlocs.mapBloc.add(FollowPositionEvent(shouldTiltCamera: false, shouldZoomCamera: true));

              AppBlocs.routingBloc.add(CancelBuildRouteEvent());

              SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                systemNavigationBarContrastEnforced: true,
                systemNavigationBarIconBrightness: Brightness.light,
              ));
            } else if (navigationState.status == NavigationStatus.finished) {
              AppBlocs.routingBloc.add(ResetEvent());
              AppBlocs.mapBloc
                ..add(RemoveAllRoutesEvent())
                ..add(RemoveAllHighlightsEvent());
              AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.initializedMap));
              AppBlocs.positionPredictionBloc.add(UnregisterPositionTransferEvent());
            } else if (navigationState.status == NavigationStatus.stopped) {
              AppBlocs.routingBloc.add(ResetEvent());
              AppBlocs.mapBloc
                ..add(RemoveAllRoutesEvent())
                ..add(RemoveAllHighlightsEvent());
              AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.initializedMap));
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
