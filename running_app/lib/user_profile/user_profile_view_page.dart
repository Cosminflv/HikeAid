import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileViewPage extends StatelessWidget {
  const UserProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.user, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
