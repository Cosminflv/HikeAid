import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/theme.dart';

class SearchNoResultsPage extends StatelessWidget {
  const SearchNoResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: getAppbarColor(context),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Icon(
            FontAwesomeIcons.xmark,
            size: 60,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              AppLocalizations.of(context)!.noResultsFound,
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
