import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> showUnfriendConfirmation(BuildContext context, String name) async {
  final isIos = isCupertino(context);

  return await (isIos
          ? showCupertinoModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              shadow: const BoxShadow(color: Colors.transparent),
              builder: (context) => CupertinoActionSheet(
                title: const Text("Unfriend"),
                message: Center(child: Text("Are you sure you want to unfriend $name")),
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
                    child: Text(AppLocalizations.of(context)!.logoutTitle),
                  ),
                ],
              ),
            )
          : showModalBottomSheet(
              context: context,
              builder: (context) => Wrap(
                children: [
                  ListTile(
                    title: const Center(
                      child: Text("Unfriend"),
                    ),
                    subtitle: Center(
                      child: Text(
                        "Unfriend $name?",
                      ),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            "Unfriend",
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(AppLocalizations.of(context)!.cancel,
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
