import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TourScaffoldTemplate extends StatelessWidget {
  final Widget body;
  final List<Widget> actions;
  final String? title;
  final Widget? leading;
  final bool automaticallyImplyLeading;

  const TourScaffoldTemplate({
    super.key,
    required this.body,
    this.actions = const [],
    this.title,
    this.automaticallyImplyLeading = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PlatformAppBar(
        leading: leading,
        title: title != null ? Text(title!, style: Theme.of(context).textTheme.titleMedium) : null,
        backgroundColor:
            automaticallyImplyLeading ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.tertiary,
        automaticallyImplyLeading: automaticallyImplyLeading,
        material: (context, platform) => MaterialAppBarData(
          elevation: automaticallyImplyLeading ? null : 0,
          iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        ),
        cupertino: (context, platform) => CupertinoNavigationBarData(
            previousPageTitle: "Back",
            automaticallyImplyLeading: automaticallyImplyLeading,
            border: automaticallyImplyLeading ? null : const Border.fromBorderSide(BorderSide.none)),
        trailingActions: actions,
      ),
      body: body,
    );
  }
}
