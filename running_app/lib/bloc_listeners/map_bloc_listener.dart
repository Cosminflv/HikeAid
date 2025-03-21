import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/shared_widgets/bottom_sheets/landmark_panel_bottom_sheet.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/map/map_view_state.dart';
import 'package:running_app/utils/sizes.dart';

class MapBlocListener extends StatelessWidget {
  final Widget child;

  const MapBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<MapViewBloc, MapViewState>(
        listener: _mapViewBlocListener,
        listenWhen: (previous, current) =>
            previous.mapSelectedLandmark != current.mapSelectedLandmark && current.mapSelectedLandmark != null,
      ),
      BlocListener<MapViewBloc, MapViewState>(
        listener: (context, state) {
          LandmarkPanelBottomSheet.show(context);
        },
        listenWhen: (previous, current) =>
            previous.mapSelectedLandmark != current.mapSelectedLandmark && current.mapSelectedLandmark != null,
      ),
      BlocListener<MapViewBloc, MapViewState>(
        listener: (context, state) {
          final alertBloc = AppBlocs.alertBloc;
          final presentedAlerts = alertBloc.state.alerts;
          for (final alert in presentedAlerts) {
            if (alert.coordinates.isEqual(state.mapSelectedAlertCoords!)) {
              alertBloc.add(AlertSelectedEvent(pickedAlert: alert));
              break;
            }
          }
        },
        listenWhen: (previous, current) =>
            previous.mapSelectedAlertCoords != current.mapSelectedAlertCoords && current.mapSelectedAlertCoords != null,
      )
    ], child: child);
  }

  void _mapViewBlocListener(BuildContext context, MapViewState state) {
    _presentHighlightOnMap(state, context);
  }

  void _presentHighlightOnMap(MapViewState state, BuildContext context) {
    final mapViewBloc = AppBlocs.mapBloc;

    mapViewBloc.add(PresentHighlightEvent(
      landmark: state.mapSelectedLandmark!,
      screenPosition: Sizes.getMapVisibleArea(context).center,
      isPin: true,
      showLabel: false,
    ));
  }
}
