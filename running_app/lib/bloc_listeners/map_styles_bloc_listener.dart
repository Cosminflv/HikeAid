import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/config/device_info.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/map_styles/map_styles_panel_bloc.dart';
import 'package:running_app/map_styles/map_styles_panel_state.dart';
import 'package:running_app/settings/settings_view_events.dart';

import '../shared_widgets/bottom_sheets/map_styles_bottom_sheet.dart';

class MapStylesBlocListener extends StatelessWidget {
  final Widget child;

  const MapStylesBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<MapStylesPanelBloc, MapStylesPanelState>(
        listener: _mapStylesBlocListener,
        listenWhen: (previous, current) => previous.isVisible != current.isVisible,
      ),
      // Applying a mapstyle at startup, without animation
      BlocListener<MapStylesPanelBloc, MapStylesPanelState>(
        listenWhen: (previous, current) =>
            previous.selectedMapStyle != current.selectedMapStyle && previous.selectedMapStyle == null,
        listener: (context, state) async {
          OSCompatibilityChecker.canApplyMapStyle().then((canApply) {
            if (!canApply) return;
            AppBlocs.mapBloc.add(ApplyMapStyleByPathEvent(path: state.selectedMapStyle!.path, smoothTransition: false));

            AppBlocs.settingsViewBloc.add(SavePrefferedMapStyleEvent(state.selectedMapStyle!.path));
          });
        },
      ),
      // Applying a mapstyle by user interaction
      BlocListener<MapStylesPanelBloc, MapStylesPanelState>(
        listenWhen: (previous, current) =>
            previous.selectedMapStyle != current.selectedMapStyle && previous.selectedMapStyle != null,
        listener: (context, state) {
          OSCompatibilityChecker.canApplyMapStyle().then((canApply) {
            if (!canApply) return;
            final mapBloc = AppBlocs.mapBloc;
            mapBloc.add(ApplyMapStyleByPathEvent(path: state.selectedMapStyle!.path, smoothTransition: true));

            AppBlocs.settingsViewBloc.add(SavePrefferedMapStyleEvent(state.selectedMapStyle!.path));

            if (AppBlocs.appBloc.state.isNavigating && mapBloc.state.isFollowingPosition) {
              mapBloc.add(FollowPositionEvent(shouldTiltCamera: false, shouldZoomCamera: true));
            }
          });
        },
      )
    ], child: child);
  }

  void _mapStylesBlocListener(context, state) {
    if (!state.isVisible) return;
    MapStylesModalBottomSheet.show(context);
  }
}
