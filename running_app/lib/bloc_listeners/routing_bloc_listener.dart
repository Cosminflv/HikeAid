import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:domain/use_cases/routing_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/home/home_view_state.dart';
import 'package:running_app/map/map_view_bloc.dart';
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

  MapViewBloc? _getSecondaryMapBloc() {
    try {
      return sl<MapViewBloc>(instanceName: "userHike");
    } catch (_) {
      return null;
    }
  }

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

            // Check for the secondary bloc each time the listener fires
            final secondaryMapBloc = _getSecondaryMapBloc();

            if (secondaryMapBloc != null && !secondaryMapBloc.isClosed) {
              secondaryMapBloc
                ..add(PresentRoutesEvent(
                  routes: routingState.routes,
                  viewArea: Sizes.getMapVisibleArea(context),
                  distanceUnit: getDistanceUnit(context),
                  shouldCenter: !AppBlocs.appBloc.state.isNavigating && !routingState.routes.first.isTourBased,
                ))
                ..add(RemoveAllRoutesExceptEvent(routingState.routes));
            } else {
              mapBloc
                ..add(PresentRoutesEvent(
                  routes: routingState.routes,
                  viewArea: Sizes.routesDisplayAreaMode,
                  distanceUnit: getDistanceUnit(context),
                  shouldCenter: !AppBlocs.appBloc.state.isNavigating && !routingState.routes.first.isTourBased,
                ))
                ..add(RemoveAllRoutesExceptEvent(routingState.routes));
            }

            AppBlocs.positionPredictionBloc.add(ConfirmHikeEvent(false));

            AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.routing));

            if (AppBlocs.homeViewBloc.state.type == HomePageType.map) RouteActionsBottomSheet.show(context);
          },
          listenWhen: (previous, current) =>
              previous.status == RouteBuildStatus.building && current.status == RouteBuildStatus.succes ||
              previous.status == RouteBuildStatus.succes && current.status == RouteBuildStatus.succes),
      // RoutingViewBloc when a route calculation fails
      BlocListener<RoutingViewBloc, RoutingViewState>(
          bloc: routingBloc,
          listener: (context, routingState) {
            showErrorToast(AppLocalizations.of(context)!.routeFailed);
          },
          listenWhen: (previous, current) =>
              previous.status != RouteBuildStatus.failed && current.status == RouteBuildStatus.failed),
    ], child: child);
  }
}
