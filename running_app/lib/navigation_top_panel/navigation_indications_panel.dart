import 'package:domain/settings/general_settings_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/navigation/navigation_view_bloc.dart';
import 'package:running_app/navigation/navigation_view_state.dart';
import 'package:running_app/utils/unit_converters.dart';

class NavigationIndicationsPanel extends StatelessWidget {
  const NavigationIndicationsPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationViewBloc, NavigationViewState>(
      builder: (context, navigationState) {
        return Row(
          children: [
            if (navigationState.currentInstruction?.image != null)
              SizedBox.square(dimension: 50, child: Image.memory(navigationState.currentInstruction!.image!)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.inKm} ${convertDistance(navigationState.currentInstruction!.distance, DDistanceUnit.km)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  Text(
                    navigationState.currentInstruction!.nextStreetName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
