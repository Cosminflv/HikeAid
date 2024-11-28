import 'package:core/di/app_blocs.dart';
import 'package:running_app/config/routes.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/location/location_state.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/map/map_view_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum FollowPositionActionType { followPosition, askPermission, askService }

class FollowPositionButton extends StatelessWidget {
  const FollowPositionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapViewBloc, MapViewState>(
      builder: (context, mapState) {
        if (mapState.isFollowingPosition) return Container();
        return BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
            return IconButton(
              splashColor: transparentColor,
              highlightColor: transparentColor,
              onPressed: () {
                locationState.isFollowPositionEnabled ? _handleButtonPress(context) : () {};
              },
              icon: Icon(
                  !mapState.isFollowPositionFixed
                      ? FontAwesomeIcons.locationArrow
                      : FontAwesomeIcons.locationCrosshairs,
                  color: !mapState.isFollowingPosition
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onSurface),
            );
          },
        );
      },
    );
  }

  void _handleButtonPress(BuildContext context) {
    final locationBloc = AppBlocs.locationBloc;

    final locationState = locationBloc.state;

    if (!locationState.hasLocationPermission || !locationState.isLocationEnabled) {
      Navigator.of(context).pushNamed(RouteNames.askPermissionPage).then((value) {
        if (value == true) {
          _followPosition(context);
        }
      });
    } else {
      // if (mapBloc.state.isFollowingPosition) {
      //   mapBloc.add(CompassLockCameraEvent());
      // } else {
      //   mapBloc.add(FollowPositionEvent(shouldTiltCamera: appState.status == AppStatus.navigation));
      //   mapBloc.add(SelectedLandmarkUpdatedEvent(landmark: null, forceCenter: true));
      // }
      _followPosition(context);
    }
  }

  void _followPosition(BuildContext context) {
    final mapBloc = AppBlocs.mapBloc;

    mapBloc.add(FollowPositionEvent(shouldTiltCamera: false, shouldZoomCamera: true));
    mapBloc.add(SelectedLandmarkUpdatedEvent(landmark: null, forceCenter: true));
  }
}
