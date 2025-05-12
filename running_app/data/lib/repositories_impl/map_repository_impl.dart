import 'package:data/models/camera_state_entity_impl.dart';
import 'package:data/models/landmark_entity_impl.dart';
import 'package:data/models/route_entity_impl.dart';
import 'package:data/utils/map_widget_builder_impl.dart';
import 'package:data/utils/units_converter.dart';
import 'package:domain/entities/alert_entity.dart';
import 'package:domain/entities/camera_state_entity.dart';
import 'package:shared/data/path_entity_impl.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:domain/entities/route_entity.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:domain/map_controller.dart';
import 'package:data/repositories_impl/extensions.dart';
import 'package:domain/settings/general_settings_entity.dart';
import 'package:flutter/services.dart';

import 'package:gem_kit/core.dart';
import 'package:gem_kit/map.dart';
import 'package:shared/domain/landmark_entity.dart';
import 'package:shared/domain/path_entity.dart';
import 'dart:math';

import 'package:shared/extensions.dart';

class MapRepositoryImpl extends MapRepository {
  final polylineMarkerCollection = MarkerCollection(markerType: MarkerType.polyline, name: "MarkerLine");
  final pointMarkerCollection = MarkerCollection(markerType: MarkerType.point, name: "MarkerPoint");
  final GemMapController _controller;

  MapRepositoryImpl(MapController mapController) : _controller = (mapController as MapControllerImpl).ref;

  @override
  void presentHighlights(LandmarkEntity landmark, {int? highlightId, bool showLabel = true, Uint8List? image}) {
    landmark as LandmarkEntityImpl;
    final List<Landmark> landmarksToHighlight = [];

    final settings = HighlightRenderSettings(
        options: {HighlightOptions.showLandmark, HighlightOptions.showContour, HighlightOptions.overlap});

    landmark.ref!.setImage(imageData: image ?? landmark.ref!.getImage(size: Size(128, 128))!);
    landmarksToHighlight.add(landmark.ref!);

    _controller.activateHighlight(
      landmarksToHighlight,
      renderSettings: settings,
      highlightId: highlightId,
    );
  }

  @override
  void registerMapGesturesCallbacks({
    required Function() onMapMove,
    required Function(double) onMapAngleUpdated,
    required Function(LandmarkEntity?, RouteEntity?) onTap,
    required Function(List<CoordinatesEntity>) onMarkerSelected,
  }) {
    _controller.registerMapAngleUpdateCallback(onMapAngleUpdated);
    _controller.registerMoveCallback((p1, p2) => onMapMove());

    _controller.registerTouchCallback((pos) async {
      await _controller.setCursorScreenPosition(pos);

      Landmark? selectedLandmark;
      Route? selectedRoute;

      final landmarks = _controller.cursorSelectionLandmarks();
      final markers = _controller.cursorSelectionMarkers();

      final routes = _controller.cursorSelectionRoutes();
      if (routes.isNotEmpty) {
        selectedRoute = routes.first;
      }

      if (landmarks.isNotEmpty) {
        selectedLandmark = landmarks.first;
      }
      if (markers.isNotEmpty) {
        for (final markerMatch in markers) {
          final markerCoords = markerMatch.getMarker().getCoordinates();
          final coordinates = markerCoords.map((coord) => coord.toEntityImpl()).toList();
          onMarkerSelected(coordinates);
        }
        return;
      }

      final streets = _controller.cursorSelectionStreets();
      if (streets.isNotEmpty && selectedLandmark == null) {
        selectedLandmark = streets.first;
      }

      if (selectedLandmark == null) {
        final coordinates = _controller.transformScreenToWgs(Point(pos.x, pos.y));
        Landmark lmk = Landmark();
        lmk.coordinates = coordinates;
        lmk.name = 'Map Pin';
        lmk.setImageFromIcon(GemIcon.searchResultsPin);
        selectedLandmark = lmk;
      }

      onTap(selectedLandmark.toEntityImpl(), selectedRoute?.toEntityImpl(waypoints: []));
    });
  }

  // Center and Distance
  @override
  CoordinatesEntity? getCenterCoordinates() {
    final size = _controller.viewport;

    return _controller.transformScreenToWgs(Point(size.width ~/ 2, size.height ~/ 2)).toEntityImpl();
  }

  @override
  MapCameraStateEntity? getCameraState() {
    final coordinates = getCenterCoordinates();

    if (coordinates == null) return null;

    return MapCameraStateEntityImpl(
        coordinates: coordinates, zoom: _controller.zoomLevel, isFollowingPositon: _controller.isFollowingPosition);
  }

  @override
  void setPositionTrackerImage(Uint8List imageData, {double scale = 1.0}) {
    try {
      MapSceneObject.customizeDefPositionTracker(imageData, SceneObjectFileFormat.tex);
      final positionTracker = MapSceneObject.getDefPositionTracker();

      positionTracker.scale = scale;
    } catch (e) {}
  }

  @override
  void alignNorthUp() => _controller.alignNorthUp();

  @override
  void setEnableTouchGestures(bool enable) {
    _controller.preferences.enableTouchGestures(TouchGestures.values, enable);
  }

  // Routes
  @override
  void removeHighlight(int highlightId) => _controller.deactivateHighlight(highlightId: highlightId);

  @override
  void presentRoute(RouteEntity route, {bool isMainRoute = false, bool hasLabel = true, (int, int, int)? color}) {
    route as RouteEntityImpl;

    final mapRoutes = _controller.preferences.routes;
    final timeDistance = route.ref.getTimeDistance();

    final totalDistance = timeDistance.restrictedDistanceM + timeDistance.unrestrictedDistanceM;
    final totalTime = timeDistance.restrictedTimeS + timeDistance.unrestrictedTimeS;

    final formattedDistance = convertDistance(totalDistance, DDistanceUnit.km);
    final formattedTime = convertDuration(totalTime);

    final settings = RouteRenderSettings(
      turnArrowInnerSz: 2.5,
      turnArrowOuterSz: 1.5,
      turnArrowInnerColor: Color.fromARGB(255, 255, 255, 255),
      turnArrowOuterColor: Color.fromARGB(255, 21, 29, 85),
    );
    settings.innerSz = 1.25;
    settings.outerSz = 0.5;

    settings.options = {RouteRenderOptions.showTurnArrows};

    if (color != null) {
      settings.fillColor = Color.fromARGB(100, color.$1, color.$2, color.$3);
    }

    mapRoutes.add(route.ref, isMainRoute,
        label: hasLabel ? '$formattedTime \n $formattedDistance' : null, routeRenderSettings: settings);
  }

  @override
  void presentRouteSummary(RouteEntity route) {
    route as RouteEntityImpl;

    final mapRoutes = _controller.preferences.routes;

    mapRoutes.add(route.ref, true);
  }

  @override
  void setMainRoute(RouteEntity route) async {
    route as RouteEntityImpl;

    final mainRouteRenderSettings = RouteRenderSettings();
    mainRouteRenderSettings.options = {
      RouteRenderOptions.showTurnArrows,
    };
    mainRouteRenderSettings.innerSz = 1.25;
    mainRouteRenderSettings.outerSz = 0.5;

    final alternativeRouteRenderSettings = RouteRenderSettings();
    alternativeRouteRenderSettings.options = {
      RouteRenderOptions.showTurnArrows,
    };
    alternativeRouteRenderSettings.innerSz = 1.25;
    alternativeRouteRenderSettings.outerSz = 0.5;

    final routes = _controller.preferences.routes;

    for (final mapRoute in routes) {
      if (mapRoute.equals(route.ref)) {
        routes.setRenderSettings(mapRoute, mainRouteRenderSettings);
      } else {
        routes.setRenderSettings(mapRoute, alternativeRouteRenderSettings);
      }
    }

    routes.mainRoute = route.ref;

    // routes.setRenderSettings(route.ref, mainRouteRenderSettings);

    // routes.setRenderSettings(mainRoute, mainRouteRenderSettings);
  }

  @override
  void clearAllButMainRoute() async {
    final routes = _controller.preferences.routes;
    routes.clearAllButMainRoute();
  }

  @override
  void clearRoutes() => _controller.preferences.routes.clear();

  @override
  void removeRoute(RouteEntity route) {
    route as RouteEntityImpl;
    _controller.preferences.routes.remove(route.ref);
  }

  @override
  void clearRouteExcept(List<RouteEntity> routes) {
    final mapRoutes = _controller.preferences.routes;

    final gemRoutes = routes.map((e) {
      e as RouteEntityImpl;
      return e.ref;
    });

    final routesToRemove = mapRoutes.where((element1) {
      return !gemRoutes.any((element2) => element1.equals(element2));
    }).toList();

    for (final route in routesToRemove) {
      _controller.preferences.routes.remove(route);
    }
  }

  @override
  void clearHighlights() => _controller.deactivateAllHighlights();

  @override
  void applyMapStyleByPath({required String path, bool smoothTransition = true}) =>
      _controller.preferences.setMapStyleByPath(path, smoothTransition: smoothTransition);

  @override
  Future<void> addAlerts(List<AlertEntity> alerts) async {
    List<MarkerWithRenderSettings> markers = [];

    for (final alert in alerts) {
      final ByteData alertIconData = await rootBundle.load(alert.type.alertIconName);
      final Uint8List alertIcon = alertIconData.buffer.asUint8List();

      final alertMarker = MarkerJson(coords: [alert.coordinates.toGemCoordinates()], name: alert.title);

      final renderSettings = MarkerRenderSettings(image: GemImage(image: alertIcon, format: ImageFileFormat.png));

      markers.add(MarkerWithRenderSettings(alertMarker, renderSettings));
    }
    final settings = MarkerCollectionRenderSettings(pointsGroupingZoomLevel: 0);
    settings.labelGroupTextSize = 2;

    _controller.preferences.markers.addList(list: markers, settings: settings, name: "Markers");
  }

  @override
  void addPolylineMarker({required List<CoordinatesEntity> coordinates}) {
    if (polylineMarkerCollection.size == 0) {
      final marker = Marker();
      marker.setCoordinates(coordinates.map((e) => e.toGemCoordinates()).toList());

      polylineMarkerCollection.add(marker);

      _controller.preferences.markers.add(polylineMarkerCollection,
          settings: MarkerCollectionRenderSettings(
            polylineInnerColor: Color.fromARGB(255, 92, 150, 68),
            polylineOuterColor: Color.fromARGB(255, 255, 255, 255),
            polylineOuterSize: 1,
            polylineInnerSize: 1.5,
          ));

      return;
    }
    final marker = polylineMarkerCollection.getMarkerAt(0);
    marker.setCoordinates(coordinates.map((e) => e.toGemCoordinates()).toList());
  }

  @override
  Future<Uint8List?> captureImage() async => await _controller.captureImage();

  @override
  void clearMarkers() {
    _controller.preferences.markers.clear();
    polylineMarkerCollection.clear();
    pointMarkerCollection.clear();
  }

  @override
  void clearPaths() => _controller.preferences.paths.clear();

  @override
  void presentPath(PathEntity path) {
    path as PathEntityImpl;
    _controller.preferences.paths.add(path.ref);
  }
}
