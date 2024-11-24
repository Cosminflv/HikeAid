import 'package:core/di/app_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/location/location_state.dart';
import 'package:running_app/map/map_view_event.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationBlocListener extends StatelessWidget {
  final Widget child;

  const LocationBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<LocationBloc, LocationState>(
        listener: (context, locationState) {
          if (locationState.openLocationPanel == true) {
            AppBlocs.mapBloc.add(SelectedLandmarkUpdatedEvent(
                landmark: null,
                forceCenter: true,
                coordinates: locationState.currentPosition?.coordinates,
                name: AppLocalizations.of(context)!.myPosition));
          }
        },
        listenWhen: (previous, current) => previous.currentPosition == null && current.currentPosition != null,
      ),
    ], child: child);
  }
}
