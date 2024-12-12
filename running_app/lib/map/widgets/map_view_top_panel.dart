import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/app/trip_record/tour_record__page.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_state.dart';
import 'package:running_app/map/widgets/compass_button.dart';
import 'package:running_app/navigation_top_panel/navigation_top_panel.dart';

class MapViewTopPanel extends StatefulWidget {
  final double topPadding;
  const MapViewTopPanel({super.key, required this.topPadding});

  @override
  State<MapViewTopPanel> createState() => _MapViewTopPanelState();
}

class _MapViewTopPanelState extends State<MapViewTopPanel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, appState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (appState.isNavigating)
                NavigationTopPanel(
                  totalDistance: AppBlocs.mapBloc.state.mapSelectedRoute?.distance.toInt() ?? 0,
                  totalDuration: AppBlocs.mapBloc.state.mapSelectedRoute?.duration.toInt() ?? 0,
                  topPadding: widget.topPadding,
                ),
              if (appState.isRecording)
                Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    children: [
                      SizedBox(height: widget.topPadding),
                      const SizedBox(height: 200, child: RecorderInformationPanel()),
                    ],
                  ),
                ),
              // BlocBuilder<MapViewBloc, MapViewState>(
              //   builder: (context, mapState) {
              //     if (mapState.isFollowingPosition) return const SizedBox.shrink();
              //     return const CompassButton();
              //   },
              // ),
            ],
          );
        });
  }
}
