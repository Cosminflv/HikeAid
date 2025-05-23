import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/app/trip_record/tour_record__page.dart';
import 'package:running_app/home/home_view_bloc.dart';
import 'package:running_app/home/home_view_events.dart';
import 'package:running_app/internet_connection/internet_connection_checker.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/map/map_view_page.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';
import 'package:running_app/user_profile/user_profile_view_page.dart';
import 'package:running_app/utils/session_utils.dart';
import 'package:running_app/utils/sizes.dart';
import 'package:running_app/widgets/alerts_notifications.dart';

import 'home_view_state.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  @override
  void initState() {
    //AppBlocs.routePlanningBloc.add(InitRoutePlanningEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) => AppBlocs.homeViewBloc.add(SetCurrentHomeViewEvent(HomePageType.values.first)),
      listenWhen: (previous, current) => !previous.isRecording && current.isRecording,
      child: BlocBuilder<HomeViewBloc, HomeViewState>(
        bloc: AppBlocs.homeViewBloc,
        builder: (context, homeState) {
          return Scaffold(
            extendBodyBehindAppBar: false,
            bottomNavigationBar: BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
              Sizes.updateStatusBarHeight(MediaQuery.of(context).padding.top);
              Sizes.updateBottomPadding(MediaQuery.of(context).padding.bottom);
              if (appState.isNavigating || appState.isRecording) {
                return const SizedBox.shrink();
              }
              return Container(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, boxShadow: [
                  BoxShadow(blurRadius: 0, spreadRadius: 1, color: Theme.of(context).colorScheme.outlineVariant)
                ]),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    elevation: 0,
                    currentIndex: homeState.type.index,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    selectedItemColor: Theme.of(context).colorScheme.primary,
                    enableFeedback: true,
                    onTap: (index) {
                      final landmark = AppBlocs.mapBloc.state.mapSelectedLandmark;

                      if (landmark != null) {
                        AppBlocs.mapBloc.add(RemoveHighlightsEvent(highlightId: landmark.id));
                        AppBlocs.mapBloc.add(SelectedLandmarkUpdatedEvent(landmark: null, forceCenter: false));
                        if (AppBlocs.homeViewBloc.state.type == HomePageType.map) Navigator.of(context).pop();
                      }

                      AppBlocs.homeViewBloc.add(SetCurrentHomeViewEvent(HomePageType.values[index]));

                      if (index == 2) {
                        AppBlocs.userProfileBloc.add(FetchUserTours(userId: getSession(context)!.user.id));
                      }
                    },
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(
                            homeState.type == HomePageType.map ? FontAwesomeIcons.solidMap : FontAwesomeIcons.map,
                            weight: 20,
                          ),
                          label: AppLocalizations.of(context)!.routes),
                      BottomNavigationBarItem(
                        icon: Icon(homeState.type == HomePageType.record
                            ? FontAwesomeIcons.solidCircleDot
                            : FontAwesomeIcons.circleDot),
                        label: "Record",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(homeState.type == HomePageType.profile
                            ? FontAwesomeIcons.solidUser
                            : FontAwesomeIcons.user),
                        label: AppLocalizations.of(context)!.profile,
                      ),
                    ],
                  ),
                ),
              );
            }),
            body: IndexedStack(
              index: homeState.type.index,
              children: [
                const InternetConnectionChecker(
                    showFullPage: false, canInteract: true, child: AlertNotificationHandler(child: MapViewPage())),
                const TourRecordPage(),
                InternetConnectionChecker(
                  showFullPage: true,
                  canInteract: true,
                  child: UserProfileViewPage(
                    isEditable: true,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
