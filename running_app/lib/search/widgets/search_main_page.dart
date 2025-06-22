import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/landmark_with_distance_entity.dart';
import 'package:running_app/config/routes.dart';
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
                          onTap: () => Navigator.of(context).pushNamed(RouteNames.searchHistoryPage),
                          trail: Icon(FontAwesomeIcons.chevronRight,
                              size: 20, color: Theme.of(context).colorScheme.primary),
                        ),
                      const Divider(),
                    ],
                  );
                }
                return SizedBox(height: MediaQuery.of(context).padding.bottom);
              }),
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
}
