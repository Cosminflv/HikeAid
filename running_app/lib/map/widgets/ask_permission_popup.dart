import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/location/location_event.dart';
import 'package:running_app/location/location_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/providers/bloc_providers.dart';

class AskPermissionPopup extends StatelessWidget {
  const AskPermissionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state.hasLocationPermission == true) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(true);
          }
        }
      },
      listenWhen: (previous, current) =>
          previous.hasLocationPermission == false && current.hasLocationPermission == true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                FontAwesomeIcons.xmark,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              )),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.enableLocationTitle, style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.enableLocationSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 5,
                    height: 215,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.enableLocationSteps,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => _handleButtonPress(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.enableLocationButton,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonPress(BuildContext context) {
    final locationBloc = BlocProviders.location(context);
    final locationState = locationBloc.state;
    if (!locationState.hasLocationPermission) {
      locationBloc.add(AskForLocationPermissionEvent());
    } else if (!locationState.isLocationEnabled) {
      locationBloc.add(OpenLocationServiceEvent());
    }
  }
}
