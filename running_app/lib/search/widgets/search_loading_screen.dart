import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/config/theme.dart';

class SearchLoadingScreen extends StatelessWidget {
  const SearchLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: getAppbarColor(context),
      child: Column(
        children: [
          LinearProgressIndicator(color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 10),
          Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 60,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              AppLocalizations.of(context)!.loadingSearch,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ));
  }
}
