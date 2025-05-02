import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:domain/map_controller.dart';
import 'package:domain/map_widget.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:domain/utils/asset_bundle_entity_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/routing/route_waypoint.dart';
import 'package:running_app/tour_recording/tour_recording_events.dart';
import 'package:running_app/tours/tour_scaffold_template.dart';
import 'package:running_app/utils/session_utils.dart';

import '../map/map_view_bloc.dart';
import '../shared_widgets/custom_text_button.dart';
import '../utils/unit_converters.dart';
import 'tour_recording_bloc.dart';
import 'tour_recording_state.dart';

import 'dart:async';
import 'dart:convert';

class TourRecordingFinishedPage extends StatefulWidget {
  const TourRecordingFinishedPage({super.key});

  @override
  State<TourRecordingFinishedPage> createState() => _TourRecordingFinishedPageState();
}

class _TourRecordingFinishedPageState extends State<TourRecordingFinishedPage> {
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
    return PopScope(
      onPopInvokedWithResult: (didPop, res) => _mapBloc.add(SetPositionTracker(true)),
      child: TourScaffoldTemplate(
        automaticallyImplyLeading: false,
        leading: PlatformIconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            CupertinoIcons.xmark,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        body: BlocConsumer<TourRecordingBloc, TourRecordingState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Material(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Theme.of(context).colorScheme.tertiary,
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                            child: Text("Tour ended",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                          child: !state.isValidTour
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    if (state.distanceTraveled != null)
                                      Text(
                                        convertDistance(state.distanceTraveled!, getDistanceUnit(context)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Theme.of(context).colorScheme.surface),
                                      ),
                                    if (state.timeInMotion != null)
                                      Text(
                                        convertTime(state.timeInMotion!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Theme.of(context).colorScheme.surface),
                                      ),
                                  ],
                                ),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Builder(builder: (context) {
                            return LayoutBuilder(builder: (context, constraints) {
                              return FutureBuilder<bool>(
                                  future: mapCompleter.future,
                                  builder: (context, snapshot) {
                                    return MapWidget(
                                      initialCoordinates: state.recordedCoordinates.isNotEmpty
                                          ? state.recordedCoordinates[(state.recordedCoordinates.length ~/ 2)].latLng
                                          : null,
                                      onMapCreated: (controller) => _onMapCreated(controller, constraints),
                                      showPlaceholder: !snapshot.hasData || snapshot.data == null,
                                    );
                                  });
                            });
                          }),
                        ),
                        SizedBox(
                            height: 60 + MediaQuery.of(context).padding.bottom,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 0.5,
                                          color: Theme.of(context).colorScheme.shadow)
                                    ]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                      child: CustomElevatedButton(
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        text: isLoading ? null : "Save Tour",
                                        leading: isLoading
                                            ? const CupertinoActivityIndicator()
                                            : const Icon(FontAwesomeIcons.bookmark),
                                        textColor: Theme.of(context).colorScheme.onPrimary,
                                        alignment: MainAxisAlignment.center,
                                        onTap: isLoading ? null : () => _onDoneTap(getSession(context)!.user.id),
                                      ),
                                    )),
                                Container(
                                  color: Theme.of(context).colorScheme.surface,
                                  height: MediaQuery.of(context).padding.bottom,
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {
            // setState(() => isLoading = false);
            // Navigator.of(context).pop();
          },
          listenWhen: (previous, current) =>
              previous.status != RecordingStatus.tourSaved && current.status == RecordingStatus.tourSaved,
        ),
      ),
    );
  }

  void _onDoneTap(int userId) {
    setState(() => isLoading = true);

    // final image = await sl.get<MapUseCase>(instanceName: 'tourDetails').captureImage();
    // final base64Img = base64Encode(image!);
    // print("IMG: $base64Img");
    // print("IMGLAST: ${base64Img[base64Img.length - 1]}");
    // AppBlocs.tourRecordingBloc.add(SaveTourEvent(preview: image));

    sl.get<MapUseCase>(instanceName: 'tourDetails').captureImage().then((image) {
      setState(() => isLoading = false);
      final base64Img = base64Encode(image!);
      print("IMG: $base64Img");
      AppBlocs.tourRecordingBloc.add(SaveTourEvent(
        userId: userId,
        preview: image,
      ));

      if (!mounted) return;
      Navigator.of(context).pop();
    });
  }

  void _onMapCreated(MapController controller, BoxConstraints constraints) async {
    initMapDependecies(controller, instanceName: 'tourDetails');

    await mapCompleter.future;
    await _performMapActions(controller);
  }

  Future<void> _performMapActions(MapController controller) async {
    final tourRecordingState = AppBlocs.tourRecordingBloc.state;
    final tourRecordingCoordinates =
        tourRecordingState.recordedCoordinates.map((coordinate) => coordinate.latLng).toList();

    _mapBloc
      ..add(
        InitMapViewEvent(
          instanceName: 'tourDetails',
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
      // ..add(ApplyMapStyleByPathEvent(
      //     path: AppBlocs.mapStylesBloc.state.styles.where((e) => e.style == MapStyles.magicDay).toList().first.path,
      //     smoothTransition: false))
      // ..add(
      //   EnablePOICategoryLayerEvent(
      //     availableCategories: AppBlocs.landmarkCategoryBloc.state.landmarkCategories,
      //     enabledCategories: [],
      //   ),
      // )
      ..add(AddPolylineMarkerEvent(tourRecordingCoordinates))
      ..add(
        PresentHighlightEvent(
          landmark: tourRecordingState.startLandmark!,
          showLabel: false,
          image: AppBlocs.routingBloc.waypointImages[RouteWaypointName.departure],
        ),
      )
      ..add(
        PresentHighlightEvent(
          landmark: tourRecordingState.endLandmark!,
          showLabel: false,
          image: AppBlocs.routingBloc.waypointImages[RouteWaypointName.destination],
        ),
      );
    Future.delayed(Durations.medium1)
        .then((val) => _mapBloc.add(CenterOnPathEvent(path: tourRecordingState.recordedPath!)));
  }
}
