import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/navigation/navigation_view_events.dart';
import 'package:running_app/tour_recording/tour_recording_events.dart';
import 'package:running_app/utils/sizes_calculator.dart';

import '../../app/app_bloc.dart';
import '../../app/app_state.dart';
import '../../utils/sizes.dart';
import '../map_view_bloc.dart';
import '../map_view_state.dart';

class NavigationBottomControls extends StatelessWidget {
  const NavigationBottomControls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (!state.isNavigating && !state.isRecording) return const SizedBox.shrink();
        return BlocBuilder<MapViewBloc, MapViewState>(
          buildWhen: (previous, current) => previous.isFollowingPosition != current.isFollowingPosition,
          builder: (context, state) {
            return Positioned(
                bottom: 10 + Sizes.bottomPadding.toDouble(),
                height: Sizes.navigationBottomControlsHeight,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!state.isFollowingPosition)
                      SizedBox(
                        width: getTextWidth(context, AppLocalizations.of(context)!.recenter,
                                Theme.of(context).textTheme.titleSmall!) +
                            55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onPressed: () => AppBlocs.mapBloc.add(FollowPositionEvent(
                              shouldTiltCamera: false, shouldZoomCamera: true, removeHighlights: false)),
                          child: Row(
                            children: [
                              const Icon(FontAwesomeIcons.locationArrow),
                              const SizedBox(width: 10),
                              Text(
                                AppLocalizations.of(context)!.recenter,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      width: getTextWidth(context, AppLocalizations.of(context)!.controls,
                              Theme.of(context).textTheme.titleSmall!) +
                          55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onPressed: () {
                          if (AppBlocs.appBloc.state.status == AppStatus.navigation) {
                            final navigationBloc = AppBlocs.navigationBloc;
                            navigationBloc.add(StopNavigationEvent());
                          } else {
                            final recordingBloc = AppBlocs.tourRecordingBloc;
                            recordingBloc.add(StopRecordingEvent());
                          }
                        },
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.stop, color: Theme.of(context).colorScheme.onPrimary, size: 25),
                            const SizedBox(width: 10),
                            Text(
                              "Cancel",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }
}
