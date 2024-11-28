import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/navigation_top_panel/navigation_top_panel_sizes.dart';

class Sizes {
  static final view = WidgetsBinding.instance.platformDispatcher.views.first;
  static final double devicePixelRatio = view.devicePixelRatio;

  static int statusBarHeight = -1;
  static int bottomPadding = -1;

  static const double landmarkIconSize = 25;
  static double get navigationBottomControlsHeight => 120.0;

  static double routeTitlePanelHeight = 60;
  static int get routesDisplayPadding => (physicalScreenWidth * 0.1).toInt();

  static int appBarHeight = 100;
  static int get physicalAppBarHeight => (appBarHeight * devicePixelRatio).toInt();

  static int bottomNavigationBar = 60;
  static int get physicalBottomNavigationBar => (bottomNavigationBar * devicePixelRatio).toInt();

  static int physicalScreenWidth = view.physicalSize.width.toInt();
  static int physicalScreenHeight = view.physicalSize.height.toInt();

  static int get screenWidth => physicalScreenWidth ~/ devicePixelRatio;
  static int get screenHeight => physicalScreenHeight ~/ devicePixelRatio;

  static PointEntity<double> getCenterOfVisibleArea(BuildContext context) {
    final appStatus = AppBlocs.appBloc.state.status;

    switch (appStatus) {
      case AppStatus.uninitialized:
      case AppStatus.intializedSDK:
      case AppStatus.drawing:
      case AppStatus.initializedMap:
        return const PointEntity(x: 0.5, y: 0.5);
      case AppStatus.navigationPaused:
      case AppStatus.recordingPaused:
      case AppStatus.routing:
      case AppStatus.recording:
      case AppStatus.navigation:
        final mapHeight = screenHeight;
        final availableHeight =
            mapHeight - NavigationTopPanelSizes.panelHeight(context) - view.padding.top / view.devicePixelRatio;
        return PointEntity(x: 0.5, y: availableHeight / mapHeight);
    }
  }

  static void updateStatusBarHeight(double height) {
    statusBarHeight = statusBarHeight == -1 ? height.toInt() : statusBarHeight;
  }

  static void updateBottomPadding(double padding) {
    bottomPadding = bottomPadding == -1 ? padding.toInt() : bottomPadding;
  }

  static ViewAreaEntity get routesDisplayAreaMode =>
      _getRoutesDisplayArea(getRouteActionsPanelHeight(true).toInt() + 30);

  static ViewAreaEntity _getRoutesDisplayArea(int physicalBottomHeight) {
    final topPadding = routeTitlePanelHeight * devicePixelRatio;
    return ViewAreaEntity(
        xy: PointEntity(x: routesDisplayPadding, y: topPadding.toInt()),
        size: SizeEntity(
          width: physicalScreenWidth - 2 * routesDisplayPadding,
          height: physicalScreenHeight -
              physicalAppBarHeight -
              (physicalBottomHeight * devicePixelRatio).toInt() -
              topPadding.toInt() -
              2 * routesDisplayPadding,
        ));
  }

  static double getRouteActionsPanelHeight(bool withRouteDetails) =>
      100 + (withRouteDetails ? 85 : view.padding.bottom / view.devicePixelRatio);

  static ViewAreaEntity getMapVisibleArea(BuildContext context) {
    final appStatus = AppBlocs.appBloc.state.status;
    final mapBloc = AppBlocs.mapBloc;

    switch (appStatus) {
      case AppStatus.uninitialized:
        break;
      case AppStatus.intializedSDK:
        break;
      case AppStatus.initializedMap:
        if (mapBloc.state.mapSelectedLandmark == null) {
          return ViewAreaEntity(
              xy: PointEntity(x: 0, y: physicalAppBarHeight),
              size: SizeEntity(
                  width: physicalScreenWidth,
                  height: physicalScreenHeight - physicalAppBarHeight - physicalBottomNavigationBar));
        } else {
          return ViewAreaEntity(
            xy: PointEntity(x: 0, y: MediaQuery.of(context).padding.top.toInt()),
            size: SizeEntity(
              width: physicalScreenWidth,
              height: (physicalScreenHeight -
                  physicalAppBarHeight -
                  physicalBottomNavigationBar -
                  MediaQuery.of(context).padding.bottom.toInt() -
                  MediaQuery.of(context).padding.top.toInt()),
            ),
          );
        }
      case AppStatus.drawing:
      case AppStatus.navigationPaused:
      case AppStatus.recordingPaused:
      case AppStatus.routing:
      case AppStatus.recording:
      case AppStatus.navigation:
    }

    return ViewAreaEntity(
        xy: const PointEntity(x: 0, y: 0), size: SizeEntity(height: physicalScreenHeight, width: physicalScreenWidth));
  }
}
