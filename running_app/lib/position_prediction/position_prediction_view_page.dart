import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/map_controller.dart';
import 'package:domain/map_widget.dart';
import 'package:domain/utils/asset_bundle_entity_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/routing/route_waypoint.dart';

import 'dart:async';

class PositionPredictionViewPage extends StatefulWidget {
  final String userName;
  const PositionPredictionViewPage({super.key, required this.userName});

  @override
  State<PositionPredictionViewPage> createState() => _PositionPredictionViewPageState();
}

class _PositionPredictionViewPageState extends State<PositionPredictionViewPage> {
  final Map<String, dynamic> arguments = {};
  final mapCompleter = Completer<bool>();
  final _mapBloc = MapViewBloc(AssetBundleEntityImpl());

  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    waitForAnimationToFinish(context, () {
      mapCompleter.complete(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
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
      body: const SafeArea(child: SizedBox()),
    );
  }

  void _onMapCreated(MapController controller, BoxConstraints constraints) async {
    initMapDependecies(controller, instanceName: 'userHike');

    await mapCompleter.future;
    await _performMapActions(controller);
  }

  Future<void> _performMapActions(MapController controller) async {
    final positionPredictionState = AppBlocs.positionPredictionBloc.state;
    final currentUserHike = positionPredictionState.currentUserHike;

    _mapBloc
      ..add(
        InitMapViewEvent(
          instanceName: 'userHike',
          screenCenter: const PointEntity(x: 200, y: 200),
          isInteractive: false,
          mapVisibleAreaFunction: () => const ViewAreaEntity(
            xy: PointEntity(x: 20, y: 20),
            size: SizeEntity(height: 200, width: 200),
          ),
          centerOfVisibleAreaFunction: () => const PointEntity(x: 0.5, y: 0.5),
        ),
      )
      ..add(SetPositionTracker(false))
      ..add(AddPolylineMarkerEvent(currentUserHike!.trackPath.coordinates))
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
    Future.delayed(Durations.medium1).then((val) => _mapBloc.add(CenterOnPathEvent(path: currentUserHike.trackPath)));
  }
}
