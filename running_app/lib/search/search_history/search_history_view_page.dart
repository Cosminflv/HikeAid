import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/landmark_store/landmark_store_bloc.dart';
import 'package:running_app/landmark_store/landmark_store_events.dart';
import 'package:running_app/landmark_store/landmark_store_state.dart';
import 'package:running_app/search/search_menu_bloc.dart';
import 'package:running_app/search/search_menu_events.dart';
import 'package:running_app/search/search_menu_state.dart';
import 'package:running_app/search/widgets/search_list_item.dart';
import 'package:running_app/utils/map_blocs_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchHistoryViewPage extends StatelessWidget {
  const SearchHistoryViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    const dividerIndent = 40.0;

    return BlocListener<SearchMenuBloc, SearchMenuState>(
      listener: (context, state) {
        Navigator.of(context).pop(state.selectedLandmark!);
      },
      listenWhen: (previous, current) =>
          previous.selectedLandmark != current.selectedLandmark && current.selectedLandmark != null,
      child: MapBlocsProvider(
        child: PlatformScaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: PlatformAppBar(
            backgroundColor: getAppbarColor(context),
            cupertino: (context, platform) =>
                CupertinoNavigationBarData(previousPageTitle: AppLocalizations.of(context)!.search),
            title: Text(
              AppLocalizations.of(context)!.searchHistory,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            material: (context, platform) => MaterialAppBarData(
              centerTitle: true,
              iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
            ),
            trailingActions: [
              BlocBuilder<LandmarkStoreBloc, LandmarkStoreState>(
                builder: (context, state) {
                  return PlatformTextButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      AppLocalizations.of(context)!.clear,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () => _handleClearHistoryTap(context),
                  );
                },
              )
            ],
          ),
          body: BlocBuilder<LandmarkStoreBloc, LandmarkStoreState>(
            builder: (context, state) {
              final historyLandmarks = _getHistoryLandmarkWithDistance(context).reversed.toList();
              return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: historyLandmarks.length,
                itemBuilder: (context, index) => LandmarkListItem(
                    showExtraImage: false,
                    landmark: historyLandmarks[index],
                    onTap: () => _landmarkTapped(context, historyLandmarks[index])),
                separatorBuilder: (BuildContext context, int index) => const Divider(indent: dividerIndent),
              );
            },
          ),
        ),
      ),
    );
  }

  List<LandmarkWithDistanceEntity> _getHistoryLandmarkWithDistance(BuildContext context) {
    final landmarkStoreBloc = AppBlocs.searchHistoryLandmarkStoreBloc;
    final lmks = landmarkStoreBloc.state.landmarks;
    final coordinates = AppBlocs.mapBloc.state.cameraState!.coordinates;
    return lmks.map((lmk) => LandmarkWithDistanceEntity(lmk, coordinates)).toList();
  }

  void _landmarkTapped(BuildContext context, LandmarkWithDistanceEntity landmark) {
    final searchMenuBloc = AppBlocs.searchMenuBloc;
    searchMenuBloc.add(ResultSelectedEvent(result: landmark.landmark));
  }

  void _handleClearHistoryTap(BuildContext context) {
    final searchHistoryBloc = AppBlocs.searchHistoryLandmarkStoreBloc;
    searchHistoryBloc.add(ClearStoreEvent());
    Navigator.of(context).pop();
  }
}
