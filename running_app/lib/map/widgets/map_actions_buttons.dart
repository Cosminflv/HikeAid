import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_state.dart';
import 'package:running_app/map/widgets/follow_position_button.dart';
import 'package:running_app/map_styles/map_styles_panel_events.dart';

class MapActionsButtons extends StatelessWidget {
  const MapActionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        if (appState.isNavigating && appState.isRecording) return const SizedBox.shrink();
        return BlocBuilder<MapViewBloc, MapViewState>(
          builder: (context, mapState) {
            if (!mapState.isFollowingPosition) {
              return AnimatedPositioned(
                duration: Durations.short1,
                bottom: 10.0,
                right: 0,
                child: Container(
                  height: 100,
                  width: 40,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: getAppbarColor(context),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                HapticFeedback.heavyImpact();
                                AppBlocs.mapStylesBloc.add(ToggleMapStylesVisibilityEvent());
                              },
                              icon: Icon(
                                FontAwesomeIcons.layerGroup,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ))),
                      const Divider(height: 0),
                      const Expanded(child: FollowPositionButton()),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
