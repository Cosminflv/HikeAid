import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:domain/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gem_kit/map.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/bloc_listeners/map_page_bloc_listeners.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/location/location_event.dart';
import 'package:running_app/map/widgets/map_actions_buttons.dart';
import 'package:running_app/map/widgets/map_view_top_panel.dart';
import 'package:running_app/map/widgets/navigation_bottom_controls.dart';
import 'package:running_app/search/search_menu_events.dart';
import 'package:running_app/shared_widgets/search_app_bar.dart';
import 'package:running_app/utils/common_handlers.dart';
import 'package:running_app/utils/map_blocs_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  @override
  void initState() {
    initBlocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapBlocsProvider(
        child: MapPageBlocListeners(
          child: Scaffold(
            extendBodyBehindAppBar: false,
            appBar: SearchAppBar(
              automaticallyImplyLeading: false,
              isInMapView: true,
              title: Hero(
                  tag: 'searchBar',
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => _handleSearchBarTap(context),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(
                                    FontAwesomeIcons.magnifyingGlass,
                                    size: 20,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.search,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            body: Stack(
              children: [
                Builder(builder: (context) {
                  return MapWidget(
                    key: const ValueKey('MapWidget'),
                    authorizationToken:
                        "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIyMmRhMzc4ZC1kMGE4LTRjZTItYjljYS1lMGU5N2YxZGU3NzkiLCJleHAiOjE3NTEzMTcyMDAsImlzcyI6Ik1hZ2ljIExhbmUiLCJqdGkiOiIxMjU3NTY1MC1lMGU5LTRkM2YtODE4Zi1jNTY4NGNjY2U0YmUifQ.RyLbm3rxMTRlnune8wlaYULk-oYqfOjSxdQWbBN-SDQ_d3eN9u_ZRgoYC7ZbSJLau28kTtzPLwCGYfrkJK0zqQ",
                    onMapCreated: (controller) {
                      final appBloc = AppBlocs.appBloc;
                      final locationBloc = AppBlocs.locationBloc;
                      AppBlocs.appBloc.add(UpdateAppStatusEvent(AppStatus.intializedSDK));
      
                      initMapDependecies(controller);
                      locationBloc.add(InitializeLocationEvent());
                      appBloc.add(UpdateAppStatusEvent(AppStatus.initializedMap));
                    },
                  );
                }),
                const MapActionsButtons(),
                Positioned(
                  top: 0,
                  child: MapViewTopPanel(topPadding: MediaQuery.of(context).padding.top),
                ),
                const NavigationBottomControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleSearchBarTap(BuildContext context) {
    final searchBloc = AppBlocs.searchMenuBloc;

    Navigator.of(context).pushNamed(RouteNames.searchPage).then((result) {
      searchBloc.add(ClearSearchEvent());
      handleSearchOrPlanningResult(result, context);
    });
  }
}
