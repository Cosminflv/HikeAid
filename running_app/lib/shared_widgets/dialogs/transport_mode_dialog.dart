import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/transport_means.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/routing/routing_view_events.dart';

Future<bool> showTransportModeChoice(BuildContext context) async {
  final isIos = isCupertino(context);

  return await (isIos
          ? showCupertinoModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              shadow: const BoxShadow(color: Colors.transparent),
              builder: (context) => CupertinoActionSheet(
                title: Text(AppLocalizations.of(context)!.logoutTitle),
                message: Text(AppLocalizations.of(context)!.logout),
                cancelButton: CupertinoActionSheetAction(
                  child: Text(AppLocalizations.of(context)!.cancel,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Theme.of(context).colorScheme.onSurface)),
                  onPressed: () => Navigator.pop(context, false),
                ),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(context, true),
                    isDestructiveAction: true,
                    child: const Text("Transport Mode"),
                  ),
                ],
              ),
            )
          : showModalBottomSheet(
              context: context,
              builder: (context) => Wrap(
                children: [
                  ListTile(
                    title: Center(child: Text(AppLocalizations.of(context)!.logoutTitle)),
                    subtitle: const Center(child: Text("How will you travel?")),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            AppBlocs.routingBloc.add(SelectedTransportModeEvent(DTransportMeans.pedestrian));
                            Navigator.of(context).pop(true);
                          },
                          child: Text(
                            "By foot",
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            AppBlocs.routingBloc.add(SelectedTransportModeEvent(DTransportMeans.car));
                            Navigator.pop(context, true);
                          },
                          child: Text("By car",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.onSurface)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )) ??
      false;
}
