import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:domain/entities/search_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/landmark_store/landmark_store_bloc.dart';
import 'package:running_app/landmark_store/landmark_store_events.dart';
import 'package:running_app/landmark_store/landmark_store_state.dart';
import 'package:running_app/search/search_menu_bloc.dart';
import 'package:running_app/search/search_menu_events.dart';
import 'package:running_app/search/search_menu_state.dart';
import 'package:running_app/search/widgets/search_list_view.dart';
import 'package:running_app/search/widgets/search_loading_screen.dart';
import 'package:running_app/search/widgets/search_main_page.dart';
import 'package:running_app/search/widgets/search_no_results_page.dart';
import 'package:running_app/shared_widgets/search_app_bar.dart';
import 'package:running_app/shared_widgets/search_text_field.dart';
import 'package:running_app/utils/map_blocs_provider.dart';

import 'package:core/di/app_blocs.dart';

class SearchViewPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  SearchViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchMenuBloc = AppBlocs.searchMenuBloc;
    return MapBlocsProvider(
      child: BlocBuilder<LandmarkStoreBloc, LandmarkStoreState>(builder: (context, storeState) {
        return Scaffold(
          appBar: SearchAppBar(
            title: Hero(
              tag: 'searchBar',
              child: BlocBuilder<SearchMenuBloc, SearchMenuState>(
                bloc: searchMenuBloc,
                builder: (context, state) {
                  return SearchTextField(
                    controller: _controller,
                    onChanged: (text) {
                      final coordinates = AppBlocs.mapBloc.state.cameraState.coordinates;
                      searchMenuBloc.add(SearchTextEvent(text: text, coordinates: coordinates));
                      if (text.isEmpty) {
                        searchMenuBloc.add(ClearSearchEvent());
                      }
                    },
                    suffix: (state.status != SearchStatus.none)
                        ? IconButton(
                            onPressed: () {
                              searchMenuBloc.add(ClearSearchEvent());
                              _controller.text = '';
                            },
                            icon: Icon(
                              FontAwesomeIcons.circleXmark,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ))
                        : null,
                  );
                },
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              BlocConsumer<SearchMenuBloc, SearchMenuState>(
                bloc: searchMenuBloc,
                listener: (context, state) {
                  Navigator.of(context).pop(state.selectedLandmark!);
                },
                listenWhen: (previous, current) =>
                    previous.selectedLandmark != current.selectedLandmark && current.selectedLandmark != null,
                builder: (context, state) {
                  var displayedItems = state.results;

                  if (state.status == SearchStatus.started && displayedItems.isEmpty) {
                    if (!AppBlocs.internetConnectionBloc.state) return const SearchNoResultsPage();
                    return const SearchLoadingScreen();
                  }
                  if (state.status == SearchStatus.none) {
                    return SearchMainPage(
                      searchMenuBloc: searchMenuBloc,
                      onTap: _landmarkTapped,
                    );
                  }
                  if (displayedItems.isEmpty) return const SearchNoResultsPage();
                  return Expanded(
                    child: Column(
                      children: [
                        if (state.status == SearchStatus.started)
                          LinearProgressIndicator(color: Theme.of(context).colorScheme.primary),
                        Expanded(
                          child: SearchListView(
                              items: displayedItems, onItemTap: (landmark) => _landmarkTapped(context, landmark)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  void _landmarkTapped(BuildContext context, LandmarkWithDistanceEntity landmark) {
    {
      final landmarkStoreBloc = AppBlocs.searchHistoryLandmarkStoreBloc;
      landmark.landmark.setImage(landmark.landmark.icon!);
      landmarkStoreBloc.add(AddLandmarkToStoreEvent(landmark: landmark.landmark));

      final searchMenuBloc = AppBlocs.searchMenuBloc;
      searchMenuBloc.add(ResultSelectedEvent(result: landmark.landmark));
      // _handleBuildRouteTap(context, DTransportMeans.bike, landmark.landmark);
    }
  }

  // void _handleBuildRouteTap(BuildContext context, DTransportMeans transportMeans, LandmarkEntity? destination) {
  //   final appBloc = BlocProvider.of<AppBloc>(context);
  //   final locationBloc = BlocProvider.of<LocationBloc>(context);
  //   final mapBloc = BlocProvider.of<MapViewBloc>(context);
  //   final routingBloc = BlocProvider.of<RoutingViewBloc>(context);

  //   final appState = appBloc.state;
  //   final locationState = locationBloc.state;
  //   final mapState = mapBloc.state;

  //   final route = mapState.mapSelectedRoute;
  //   final currentPosition = locationState.currentPosition;
  //   final currentCoordinates = locationState.currentPosition?.coordinates;

  //   if (currentPosition == null) {
  //     showErrorToast(AppLocalizations.of(context)!.noGpsPosition);
  //   }

  //   switch (appState.status) {
  //     case AppStatus.uninitialized:
  //       return;
  //     case AppStatus.initializedMap:
  //       routingBloc.add(BuildRouteEvent(
  //         departureCoordinates: currentCoordinates,
  //         waypoints: [destination!],
  //       ));
  //       break;
  //     case AppStatus.routing:
  //       routingBloc.add(RebuildRouteEvent(
  //         route: route!,
  //         waypoint: destination!,
  //       ));
  //       break;
  //     case AppStatus.recording:
  //     case AppStatus.recordingPaused:
  //     case AppStatus.navigation:
  //     case AppStatus.navigationPaused:
  //       break;
  //     case AppStatus.drawing:
  //       break;
  //     case AppStatus.intializedSDK:
  //       break;
  //   }
  //   mapBloc.add(SelectedLandmarkUpdatedEvent(landmark: null, forceCenter: true));
  // }
}
