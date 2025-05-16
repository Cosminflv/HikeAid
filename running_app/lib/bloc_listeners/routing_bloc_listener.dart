import 'package:core/di/app_blocs.dart';
import 'package:domain/use_cases/routing_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/home/home_view_state.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/position_prediction/position_prediction_events.dart';
import 'package:running_app/routing/routing_view_bloc.dart';
import 'package:running_app/routing/routing_view_state.dart';
import 'package:running_app/shared_widgets/bottom_sheets/route_actions_bottom_sheet.dart';
import 'package:running_app/utils/toasts.dart';
import 'package:running_app/utils/unit_converters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/sizes.dart';

class RoutingBlocListener extends StatelessWidget {
  final Widget child;

  const RoutingBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final routingBloc = AppBlocs.routingBloc;
    final mapBloc = AppBlocs.mapBloc;

    return MultiBlocListener(listeners: [
      // RoutingViewBloc when a new route calculation starts
      BlocListener<RoutingViewBloc, RoutingViewState>(
          bloc: routingBloc,
          listener: (context, routingState) {
            if (routingState.routes.isEmpty) return;

            mapBloc
              ..add(PresentRoutesEvent(
                routes: routingState.routes,
                viewArea: Sizes.routesDisplayAreaMode,
                distanceUnit: getDistanceUnit(context),
                shouldCenter: !AppBlocs.appBloc.state.isNavigating && !routingState.routes.first.isTourBased,
              ))
              ..add(RemoveAllRoutesExceptEvent(routingState.routes));

            AppBlocs.positionPredictionBloc.add(ConfirmHikeEvent(false));

            // if (AppBlocs.appBloc.state.isNavigating) {
            //   AppBlocs.navigationBloc.add(NavigationStatusUpdatedEvent(NavigationStatus.restarting));
            //   return;
            // }

            // if (AppBlocs.appBloc.state.isDrawing) {
            //   _setWaypointsOfRoute(routingState);
            //   if (AppBlocs.homeViewBloc.state.type == HomePageType.map) RouteActionsBottomSheet.show(context);
            //   return;
            // }

            AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.routing));

            // if (routingState.routes.first.isTourBased) {
            //   _setWaypointsOfRoute(routingState);
            //   sl
            //       .get<NavigationViewBloc>()
            //       .add(StartNavigationEvent(routingState.routes.first, 1, isNavigatingOnTour: true));
            //   return;
            // }

            // if (mapRouteProfile.isOpened) {
            //   mapRouteProfile.close();
            // }

            if (AppBlocs.homeViewBloc.state.type == HomePageType.map) RouteActionsBottomSheet.show(context);
          },
          listenWhen: (previous, current) =>
              previous.status == RouteBuildStatus.building && current.status == RouteBuildStatus.succes ||
              previous.status == RouteBuildStatus.succes && current.status == RouteBuildStatus.succes),
      // RoutingViewBloc when a route calculation fails
      BlocListener<RoutingViewBloc, RoutingViewState>(
          bloc: routingBloc,
          listener: (context, routingState) {
            // final routePlanningBloc = AppBlocs.routePlanningBloc;
            // final previousState = routePlanningBloc.state.previousState;

            // mapBloc.add(RemoveAllHighlightsEvent());
            showErrorToast(AppLocalizations.of(context)!.routeFailed);

            // if (previousState == null) {
            //   AppBlocs.routePlanningBloc.add(ResetRoutePlanningEvent());
            //   AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.initializedMap));
            //   return;
            // }

            // routePlanningBloc.add(RevertToPreviousStateEvent());

            // if (appBloc.state.isNavigating || previousState.waypoints.length >= 2) return;

            // AppBlocs.routePlanningBloc.add(ResetRoutePlanningEvent());
            // AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.initializedMap));
          },
          listenWhen: (previous, current) =>
              previous.status != RouteBuildStatus.failed && current.status == RouteBuildStatus.failed),
    ], child: child);
  }

  // _setWaypointsOfRoute(RoutingViewState routingState) {
  //   final departureLmk = routingState.routes.first.getLandmarkAtDistance(0);
  //   final destinationLmk = routingState.routes.first.getLandmarkAtDistance(routingState.routes.first.distance);

  //   if (departureLmk == null || destinationLmk == null) {
  //     AppBlocs.routingBloc.add(RouteBuildStatusUpdatedEvent(RouteBuildStatus.failed));
  //     return;
  //   }

  //   final departureWaypoint =
  //       RouteWaypoint(landmark: departureLmk, type: RouteWaypointType.departure, name: 'Departure');
  //   final destinationWaypoint =
  //       RouteWaypoint(landmark: destinationLmk, type: RouteWaypointType.destination, name: 'Destination');

  //   if (AppBlocs.routePlanningBloc.state.routeWayType == RouteWayType.roundTrip) {
  //     AppBlocs.routePlanningBloc.add(UpdateRouteWayType(RouteWayType.oneWay));
  //   }

  //   AppBlocs.routePlanningBloc.add(UpdateWaypointsEvent(waypoints: [departureWaypoint, destinationWaypoint]));
  // }
}
