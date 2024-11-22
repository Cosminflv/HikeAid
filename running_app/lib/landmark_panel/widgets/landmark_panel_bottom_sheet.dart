import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/landmark_panel/landmark_panel.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/map/map_view_state.dart';

class LandmarkPanelBottomSheet {
  static PersistentBottomSheetController? _controller;
  static PersistentBottomSheetController? show(BuildContext context) {
    _controller = showBottomSheet(
      context: context,
      enableDrag: false,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      ),
      builder: (context) => BlocBuilder<MapViewBloc, MapViewState>(
        bloc: AppBlocs.mapBloc,
        buildWhen: (previous, current) => previous.mapSelectedLandmark != current.mapSelectedLandmark,
        builder: (context, mapViewState) {
          // final landmarkToDisplay =
          //     routePlanningState.getWaypointForLandmark(mapViewState.mapSelectedLandmark!)?.landmark ??
          //         mapViewState.mapSelectedLandmark!;
          return LandmarkPanel(
            landmark: mapViewState.mapSelectedLandmark!,
            onCloseTap: () => _handleOnCloseTap(context, mapViewState),
          );
        },
      ),
    );

    return _controller;
  }

  static bool get isOpen => _controller != null;

  static void close() {
    if (_controller != null) {
      _controller!.close();
    }
  }

  static void _handleOnCloseTap(BuildContext context, MapViewState state) {
    final mapViewBloc = AppBlocs.mapBloc;

    mapViewBloc.add(RemoveHighlightsEvent(highlightId: state.mapSelectedLandmark!.id));
    Navigator.of(context).pop();
  }
}
