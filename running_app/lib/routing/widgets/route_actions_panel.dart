import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/landmark_panel/widgets/landmark_panel_button.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/navigation/navigation_view_bloc.dart';
import 'package:running_app/navigation/navigation_view_events.dart';
import 'package:running_app/navigation/navigation_view_state.dart';
import 'package:running_app/routing/routing_view_events.dart';
import 'package:running_app/routing/widgets/route_details_panel.dart';
import 'package:running_app/shared_widgets/route_action_button.dart';

import '../../../shared_widgets/bottom_sheets/route_actions_bottom_sheet.dart';
import '../../../utils/sizes.dart';

class RouteActionsPanel extends StatelessWidget {
  final BuildContext? pageContext;

  const RouteActionsPanel({super.key, this.pageContext});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        height: Sizes.getRouteActionsPanelHeight(true),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 2, color: Theme.of(context).colorScheme.shadow)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                RouteDetailsPanel(
                  onItemTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 5),
            BlocBuilder<NavigationViewBloc, NavigationViewState>(
              bloc: AppBlocs.navigationBloc,
              buildWhen: (previous, current) => previous.isSimulated != current.isSimulated,
              builder: (context, state) {
                return SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoSwitch(
                          value: state.isSimulated,
                          onChanged: (val) => AppBlocs.navigationBloc.add(ToggleSimulationEvent())),
                      const SizedBox(width: 5),
                      Text(AppLocalizations.of(context)!.simulation),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width / 2 - 15,
                  child: LandmarkPanelButton(
                    isFilled: false,
                    text: AppLocalizations.of(context)!.cancel,
                    onTap: () {
                      final mapSelectedLandmark = AppBlocs.mapBloc.state.mapSelectedLandmark;
                      AppBlocs.mapBloc.add(RemoveAllRoutesEvent());

                      if (mapSelectedLandmark != null) {
                        AppBlocs.mapBloc.add(RemoveHighlightsEvent(highlightId: mapSelectedLandmark.id));
                      }

                      AppBlocs.routingBloc.add(ResetRoutingStateEvent());
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width / 2 - 15,
                  child: RouteActionButton(
                    text: AppLocalizations.of(context)!.navigate,
                    onTap: () {
                      final locationState = sl.get<LocationBloc>().state;

                      if ((!locationState.hasLocationPermission || !locationState.isLocationEnabled) &&
                          !AppBlocs.navigationBloc.state.isSimulated) {
                        Navigator.of(context).pushNamed(RouteNames.askPermissionPage).then((value) {
                          if (value == true) {
                            _startNavigation(context);
                          }
                        });
                        return;
                      }
                      _startNavigation(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom)
          ],
        ),
      ),
    );
  }

  _startNavigation(BuildContext context) {
    final mapBloc = AppBlocs.mapBloc;
    final route = mapBloc.state.mapSelectedRoute;
    AppBlocs.navigationBloc.add(StartNavigationEvent(route!, null));

    RouteActionsBottomSheet.close();

    // withRouteDetails = false means it is in RoutePlanningPage so we have to pop the page
    // if (!withRouteDetails) {
    //   Navigator.of(context).pop();
    // }
  }
}
