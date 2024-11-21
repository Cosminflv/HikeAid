import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/search/search_menu_bloc.dart';
import 'package:running_app/search/widgets/search_category.dart';

import 'package:easy_sticky_header/easy_sticky_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';

class SearchMainPage extends StatelessWidget {
  final SearchMenuBloc searchMenuBloc;

  final Function(BuildContext, LandmarkWithDistanceEntity) onTap;

  const SearchMainPage({
    super.key,
    required this.searchMenuBloc,
    required this.onTap,
  });

  final double _dividerIndent = 40;

  @override
  Widget build(BuildContext context) {
    final historyLandmarks = _getHistoryLandmarkWithDistance(context).reversed.toList();

    return Expanded(
      child: Container(
        color: getAppbarColor(context),
        child: StickyHeader(
          child: ListView.builder(
              itemCount: 4,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                if (index == 1) {
                  if (historyLandmarks.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchCategoryHeader(index: 0, title: AppLocalizations.of(context)!.recent.toUpperCase()),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (historyLandmarks.length >= 4) ? 2 : historyLandmarks.length,
                        itemBuilder: (context, index) => SearchCategoryItem(
                          title: historyLandmarks[index].name,
                          icon: FontAwesomeIcons.clock,
                          onTap: () => onTap(context, historyLandmarks[index]),
                        ),
                        separatorBuilder: (BuildContext context, int index) => Divider(indent: _dividerIndent),
                      ),
                      if (historyLandmarks.length >= 4) Divider(indent: _dividerIndent),
                      if (historyLandmarks.length >= 4)
                        SearchCategoryItem(
                          title: AppLocalizations.of(context)!.moreFromHistory,
                          onTap: () {},
                          trail: Icon(FontAwesomeIcons.chevronRight,
                              size: 20, color: Theme.of(context).colorScheme.primary),
                        ),
                      const Divider(),
                    ],
                  );
                }
                // if (index == 2) {
                //   // return const SizedBox.shrink();
                //   return BlocBuilder<LandmarkCategoryBloc, LandmarkCategoryState>(
                //     bloc: AppBlocs.landmarkCategoryBloc,
                //     builder: (context, state) {
                //       return Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           SearchCategoryHeader(
                //               index: historyLandmarks.isEmpty ? 0 : 2,
                //               title: AppLocalizations.of(context)!.showPlaces.toUpperCase()),
                //           BlocBuilder<SettingsViewBloc, SettingsViewState>(
                //             builder: (context, settingsState) {
                //               return ListView.separated(
                //                 shrinkWrap: true,
                //                 padding: EdgeInsets.zero,
                //                 physics: const NeverScrollableScrollPhysics(),
                //                 itemCount: state.filteredLandmarkCategories.length + 2,
                //                 itemBuilder: (context, index) {
                //                   if (index == 0) {
                //                     return SearchCategoryItem(
                //                       title: AppLocalizations.of(context)!.allCategories,
                //                       icon: FontAwesomeIcons.star,
                //                       onTap: () {},
                //                       trail: Switch(
                //                         value: settingsState.selectedPoiCategories.length > 1,
                //                         onChanged: (value) {
                //                           final landmarkCategoryState = AppBlocs.landmarkCategoryBloc.state;
                //                           final settingsBloc = AppBlocs.settingsViewBloc;

                //                           settingsBloc.add(POIVisibilityChangedEvent(
                //                               areAllVisible: value,
                //                               availableLandmarkCategories:
                //                                   landmarkCategoryState.filteredLandmarkCategories));
                //                           AppBlocs.mapBloc
                //                               .add(RemoveHighlightsFromStoreEvent(DLandmarkStoreType.savedPlaces));
                //                           settingsBloc
                //                               .add(SavedPlacesVisibilityChangedEvent(areSavedPlacesVisible: false));
                //                         },
                //                       ),
                //                     );
                //                   }
                //                   if (index == 1) {
                //                     return SearchCategoryItem(
                //                       title: AppLocalizations.of(context)!.savedPlaces,
                //                       icon: FontAwesomeIcons.bookmark,
                //                       onTap: () {
                //                         AppBlocs.mapBloc
                //                             .add(PresentHighlightsFromStoreEvent(DLandmarkStoreType.savedPlaces));
                //                         AppBlocs.settingsViewBloc
                //                             .add(SavedPlacesVisibilityChangedEvent(areSavedPlacesVisible: true));

                //                         final landmarkCategoryState = AppBlocs.landmarkCategoryBloc.state;
                //                         AppBlocs.settingsViewBloc.add(POIVisibilityChangedEvent(
                //                             areAllVisible: false,
                //                             availableLandmarkCategories:
                //                                 landmarkCategoryState.filteredLandmarkCategories));

                //                         Navigator.of(context).pop();
                //                       },
                //                       trail: (settingsState.areSavedPlacesVisible)
                //                           ? Icon(FontAwesomeIcons.circleCheck,
                //                               size: 20, color: Theme.of(context).colorScheme.primary)
                //                           : null,
                //                     );
                //                   }
                //                   return SearchCategoryItem(
                //                     title: state.filteredLandmarkCategories[index - 2].name,
                //                     image: state.filteredLandmarkCategories[index - 2].icon,
                //                     onTap: () {
                //                       final settingsBloc = AppBlocs.settingsViewBloc;
                //                       final landmarkCategoryState = AppBlocs.landmarkCategoryBloc.state;
                //                       settingsBloc.add(POIVisibilityChangedEvent(
                //                         category: state.filteredLandmarkCategories[index - 2],
                //                         availableLandmarkCategories: landmarkCategoryState.filteredLandmarkCategories,
                //                       ));

                //                       AppBlocs.mapBloc
                //                           .add(RemoveHighlightsFromStoreEvent(DLandmarkStoreType.savedPlaces));
                //                       settingsBloc.add(SavedPlacesVisibilityChangedEvent(areSavedPlacesVisible: false));

                //                       Navigator.of(context).pop();
                //                     },
                //                     trail: (settingsState.selectedPoiCategories
                //                             .contains(state.filteredLandmarkCategories[index - 2]))
                //                         ? Icon(FontAwesomeIcons.circleCheck,
                //                             size: 20, color: Theme.of(context).colorScheme.primary)
                //                         : null,
                //                   );
                //                 },
                //                 separatorBuilder: (BuildContext context, int index) => Divider(
                //                   indent: _dividerIndent,
                //                 ),
                //               );
                //             },
                //           )
                //         ],
                //       );
                //     },
                //   );
                // }
                return SizedBox(height: MediaQuery.of(context).padding.bottom);
              }),
        ),
      ),
    );
  }

  List<LandmarkWithDistanceEntity> _getHistoryLandmarkWithDistance(BuildContext context) {
    final landmarkStoreBloc = AppBlocs.searchHistoryLandmarkStoreBloc;
    final lmks = landmarkStoreBloc.state.landmarks;
    final coordinates = AppBlocs.mapBloc.state.cameraState.coordinates;
    return lmks.map((lmk) => LandmarkWithDistanceEntity(lmk, coordinates)).toList();
  }
}
