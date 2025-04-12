// import 'package:core/di/app_blocs.dart';
// import 'package:shared/domain/landmark_entity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:running_app/widgets/disabling_widget.dart';

// import '../../config/routes.dart';

// enum SearchActionType {
//   currentLocation,
//   chooseOnMap,
//   savedPlaces,
//   deleteWaypoint;

//   String label(BuildContext context) {
//     switch (this) {
//       case SearchActionType.currentLocation:
//         return AppLocalizations.of(context)!.myPosition;
//       case SearchActionType.chooseOnMap:
//         return AppLocalizations.of(context)!.mapSelection;
//       case SearchActionType.savedPlaces:
//         return AppLocalizations.of(context)!.savedPlaces;
//       case SearchActionType.deleteWaypoint:
//         return AppLocalizations.of(context)!.deleteWaypoint;
//     }
//   }

//   IconData get icon {
//     switch (this) {
//       case SearchActionType.currentLocation:
//         return FontAwesomeIcons.locationArrow;
//       case SearchActionType.chooseOnMap:
//         return FontAwesomeIcons.map;
//       case SearchActionType.savedPlaces:
//         return FontAwesomeIcons.bookmark;
//       case SearchActionType.deleteWaypoint:
//         return FontAwesomeIcons.trash;
//     }
//   }
// }

// class SearchActionResult {
//   final SearchActionType type;
//   final LandmarkEntity? landmark;
//   final bool isDeleting;
//   final bool replace;

//   SearchActionResult({
//     required this.type,
//     this.landmark,
//     this.isDeleting = false,
//     this.replace = false,
//   });
// }

// class SearchActionsButtons extends StatelessWidget {
//   const SearchActionsButtons({
//     super.key,
//   });

//   bool isDisabled(int index, RoutePlanningState state) {
//     final searchItemIndex = AppBlocs.routePlanningBloc.state.selectedWaypointIndex;

//     final isDisabled = SearchActionType.values[index] == SearchActionType.deleteWaypoint &&
//         (searchItemIndex == -1 || !state.isWaypointCompletedAt(searchItemIndex));

//     return isDisabled;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RoutePlanningBloc, RoutePlanningState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: List.generate(
//                   SearchActionType.values.length,
//                   (index) => DisablingWidget(
//                         isDisabled: isDisabled(index, state),
//                         child: SearchCustomButton(
//                             name: SearchActionType.values[index].label(context),
//                             icon: SearchActionType.values[index].icon,
//                             onTap: () {
//                               if (SearchActionType.values[index] == SearchActionType.currentLocation) {
//                                 Navigator.of(context).pop(SearchActionResult(type: SearchActionType.currentLocation));
//                               }
//                               if (SearchActionType.values[index] == SearchActionType.chooseOnMap) {
//                                 Navigator.of(context).pop(SearchActionResult(type: SearchActionType.chooseOnMap));
//                               }
//                               if (SearchActionType.values[index] == SearchActionType.deleteWaypoint) {
//                                 Navigator.of(context).pop(SearchActionResult(type: SearchActionType.deleteWaypoint));
//                               }
//                             }),
//                       )),
//             ),
//             const SizedBox(height: 10),
//             const Divider()
//           ],
//         );
//       },
//     );
//   }
// }

// class SearchCustomButton extends StatelessWidget {
//   final String name;
//   final IconData icon;
//   final VoidCallback onTap;
//   final bool isDisabled;
//   const SearchCustomButton(
//       {super.key, required this.name, required this.icon, required this.onTap, this.isDisabled = false});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width / 4 - 10,
//       height: 95,
//       child: Column(
//         children: [
//           DisablingWidget(
//             isDisabled: isDisabled,
//             child: Material(
//               type: MaterialType.transparency,
//               child: InkWell(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 onTap: onTap,
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   margin: const EdgeInsets.symmetric(vertical: 5.0),
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle, color: Theme.of(context).colorScheme.surfaceContainerHighest),
//                   child: Icon(
//                     icon,
//                     color: Theme.of(context).colorScheme.onSurface,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               name,
//               style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSurface),
//               textAlign: TextAlign.center,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
