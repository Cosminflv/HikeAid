import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/map_controller.dart';
import 'package:domain/map_widget.dart';
import 'package:domain/utils/asset_bundle_entity_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/position_prediction/position_prediction_bloc.dart';
import 'package:running_app/position_prediction/position_prediction_events.dart';
import 'package:running_app/position_prediction/position_prediction_state.dart';
import 'package:running_app/routing/routing_view_events.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:running_app/routing/route_waypoint.dart';

import 'dart:async';

class PositionPredictionViewPage extends StatefulWidget {
  final String userName;
  final int userId;
  const PositionPredictionViewPage({super.key, required this.userName, required this.userId});

  @override
  State<PositionPredictionViewPage> createState() => _PositionPredictionViewPageState();
}

class _PositionPredictionViewPageState extends State<PositionPredictionViewPage> {
  final Map<String, dynamic> arguments = {};
  final mapCompleter = Completer<bool>();
  final _mapBloc = MapViewBloc(AssetBundleEntityImpl());

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Register the _mapBloc with instance name 'userHike'
    sl.registerSingleton<MapViewBloc>(_mapBloc, instanceName: 'userHike');
  }

  @override
  void dispose() {
    // Unregister and close the bloc when the widget is disposed
    //sl.unregister<MapViewBloc>(instanceName: 'userHike');
    //_mapBloc.close();
    AppBlocs.positionPredictionBloc.add(ClearPredictionsEvent());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    waitForAnimationToFinish(context, () {
      mapCompleter.complete(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, res) => _mapBloc.add(SetPositionTracker(true)),
      child: PlatformScaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        iosContentBottomPadding: true,
        iosContentPadding: true,
        material: (context, platform) => MaterialScaffoldData(
          resizeToAvoidBottomInset: false,
        ),
        appBar: PlatformAppBar(
          title: Text(
            "${widget.userName}'s Hike",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            // 1) Your map goes *underneath*
            MapWidget(
              onMapCreated: _onMapCreated,
            ),

            // 2) Then your bar on top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                // so it doesn’t collide with status bar / notch
                child: Container(
                  height: 56, // or whatever height you want
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  alignment: Alignment.center,
                  child: BlocBuilder<PositionPredictionBloc, PositionPredictionState>(
                    buildWhen: (previous, current) => previous.currentUserHike != current.currentUserHike,
                    builder: (context, state) {
                      if (state.currentUserHike == null) {
                        return const CircularProgressIndicator();
                      }
                      final last = state.currentUserHike!.lastCoordinateTimestamp;
                      final ago = timeago.format(last, locale: 'en'); // or 'ro' for Romanian
                      return Text(
                        "Last updated: $ago",
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    },
                  ),
                ),
              ),
            ),

            BlocBuilder<PositionPredictionBloc, PositionPredictionState>(
              builder: (context, state) {
                if (state.predictedPositions.isNotEmpty) {
                  return const SizedBox.shrink();
                }
                return Positioned(
                  bottom: 16.0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomElevatedButton(
                      onTap: () {
                        AppBlocs.positionPredictionBloc.add(RequestPositionPredictionEvent(widget.userId));
                      },
                      text: "Predict positions",
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(MapController controller) async {
    initMapDependecies(controller, instanceName: 'userHike');

    await mapCompleter.future;
    await _performMapActions(controller);
  }

  Future<void> _performMapActions(MapController controller) async {
    final positionPredictionState = AppBlocs.positionPredictionBloc.state;
    final currentUserHike = positionPredictionState.currentUserHike;
    AppBlocs.routingBloc.add(BuildRouteFromPathEvent(path: currentUserHike!.trackPath));

    _mapBloc
      ..add(
        InitMapViewEvent(
          instanceName: 'userHike',
          screenCenter: const PointEntity(x: 200, y: 200),
          isInteractive: true,
          mapVisibleAreaFunction: () => const ViewAreaEntity(
            xy: PointEntity(x: 20, y: 20),
            size: SizeEntity(height: 200, width: 200),
          ),
          centerOfVisibleAreaFunction: () => const PointEntity(x: 0.5, y: 0.5),
        ),
      )
      ..add(SetPositionTracker(false))
      ..add(AddPolylineMarkerEvent(currentUserHike.progressCoordinates))
      ..add(
        PresentHighlightEvent(
          landmark: currentUserHike.startLandmark,
          showLabel: false,
          image: AppBlocs.routingBloc.waypointImages[RouteWaypointName.departure],
        ),
      )
      ..add(
        PresentHighlightEvent(
          landmark: currentUserHike.endLandmark,
          showLabel: false,
          image: AppBlocs.routingBloc.waypointImages[RouteWaypointName.destination],
        ),
      );
  }
}
