import 'dart:async';

import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/camera_state_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/navigation_instructions/navigation_instructions_panel_event.dart';
import 'package:running_app/route_terrain_profile/route_profile_panel_event.dart';
import 'package:running_app/settings/settings_view_events.dart';
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
    final navigationIntructionBloc = AppBlocs.navigationInstructionBloc;
    final terrainProfileBloc = AppBlocs.routeTerrainProfileBloc;
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
        listener: (context, mapState) {
          final settingsState = AppBlocs.settingsViewBloc.state;

          if (settingsState.isInitialized) {
            _centerCamera(context, settingsState.savedCameraState);
          } else {
            late StreamSubscription subscription;
            subscription = AppBlocs.settingsViewBloc.stream.listen((state) {
              if (!state.isInitialized) return;
              _centerCamera(context, state.savedCameraState);
              subscription.cancel();
            });
          }
        },
        listenWhen: (previous, current) => !previous.isMapCreated && current.isMapCreated,
      ),
      BlocListener<MapViewBloc, MapViewState>(
        listener: (context, mapState) {
          HapticFeedback.heavyImpact();
          navigationIntructionBloc.add(NavigationInstructionPanelUpdatedEvent(route: mapState.mapSelectedRoute!));
          terrainProfileBloc.add(RouteUpdatedEvent(route: mapState.mapSelectedRoute!));
        },
        listenWhen: (previous, current) =>
            previous.mapSelectedRoute != current.mapSelectedRoute && current.mapSelectedRoute != null,
      ),
      BlocListener<MapViewBloc, MapViewState>(
          listener: (context, mapState) =>
              AppBlocs.settingsViewBloc.add(SettingsCameraStateUpdatedEvent(mapState.cameraState!)),
          listenWhen: (previous, current) => previous.cameraState != current.cameraState),
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
    //searchBloc.add(ResultSelectedEvent(result: null));
    final mapViewBloc = AppBlocs.mapBloc;

    mapViewBloc.add(PresentHighlightEvent(
      landmark: state.mapSelectedLandmark!,
      screenPosition: Sizes.getMapVisibleArea(context).center,
      isPin: true,
      showLabel: false,
    ));
  }

  _centerCamera(BuildContext context, MapCameraStateEntity savedCameraState) {
    final mapBloc = AppBlocs.mapBloc;
    if (savedCameraState.isFollowingPositon) {
      mapBloc.add(FollowPositionEvent(
        shouldTiltCamera: false,
        shouldZoomCamera: true,
      ));
    } else {
      mapBloc.add(CenterOnCoordinatesEvent(
        coordinates: savedCameraState.coordinates,
        zoomLevel: savedCameraState.zoom,
        screenPosition: Sizes.screenCenter,
        withAnimation: false,
      ));
    }
    mapBloc.add(SetCameraStateEvent(cameraState: savedCameraState));
  }
}
