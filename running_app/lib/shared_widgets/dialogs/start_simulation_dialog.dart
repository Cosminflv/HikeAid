import 'package:core/di/app_blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/position_prediction/position_prediction_events.dart';
import 'package:running_app/utils/session_utils.dart';

Future<bool> showStartSimulationDialog(BuildContext parentContext) async {
  final isIos = isCupertino(parentContext);

  return await (isIos
          ? showCupertinoModalBottomSheet(
              context: parentContext,
              backgroundColor: Colors.transparent,
              shadow: const BoxShadow(color: Colors.transparent),
              builder: (context) => CupertinoActionSheet(
                title: Text(AppLocalizations.of(parentContext)!.logoutTitle),
                message: Text(AppLocalizations.of(parentContext)!.logout),
                cancelButton: CupertinoActionSheetAction(
                  child: Text(AppLocalizations.of(parentContext)!.cancel,
                      style: Theme.of(parentContext)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Theme.of(parentContext).colorScheme.onSurface)),
                  onPressed: () => Navigator.pop(context, false),
                ),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context, true); // Close bottom sheet
                      // Use parentContext to navigate after closing
                      Navigator.of(parentContext).pushNamed(RouteNames.askPositionTransferPage).then((value) {
                        if (value == true) {
                          AppBlocs.positionPredictionBloc.add(ReisterPositionTransferEvent(
                            getSession(parentContext)!.user.id,
                          ));
                        }
                      });
                    },
                    isDestructiveAction: true,
                    child: const Text("Transport Mode"),
                  ),
                ],
              ),
            )
          : showModalBottomSheet(
              context: parentContext,
              barrierColor: Colors.transparent,
              builder: (context) => Wrap(
                children: [
                  const ListTile(
                    title: Center(child: Text("Hike Preview")),
                    subtitle: Center(child: Text("Stâna lui Burnei - Vf. Moldoveanu")),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            AppBlocs.mapBloc.add(ClearPathsEvent());
                            AppBlocs.positionPredictionBloc.add(ConfirmHikeEvent(true));
                            Navigator.pop(context, true); // Close bottom sheet first
                            // Use parentContext to navigate after closing
                            Navigator.of(parentContext).pushNamed(RouteNames.askPositionTransferPage).then((value) {
                              if (value == true) {
                                AppBlocs.positionPredictionBloc.add(ReisterPositionTransferEvent(
                                  getSession(parentContext)!.user.id,
                                ));
                              }
                            });
                          },
                          child: Text(
                            "Calculate Route",
                            style: Theme.of(parentContext).textTheme.labelMedium!,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            AppBlocs.mapBloc.add(ClearPathsEvent());
                            AppBlocs.positionPredictionBloc.add(ConfirmHikeEvent(false));
                            Navigator.pop(context, false);
                          },
                          child: Text("Cancel",
                              style: Theme.of(parentContext)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Theme.of(parentContext).colorScheme.onSurface)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )) ??
      false;
}
