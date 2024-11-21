import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/view_area_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:running_app/app/app_state.dart';

class Sizes {
  static final view = WidgetsBinding.instance.platformDispatcher.views.first;
  static final double devicePixelRatio = view.devicePixelRatio;

  static int statusBarHeight = -1;
  static int bottomPadding = -1;

  static const double landmarkIconSize = 25;

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
        return const PointEntity(x: 0.5, y: 0.5);
      case AppStatus.recording:
      case AppStatus.navigation:
        //final mapHeight = screenHeight;
        // final availableHeight =
        //     mapHeight - NavigationTopPanelSizes.panelHeight(context) - view.padding.top / view.devicePixelRatio;
        return const PointEntity(x: 0.5, y: 0.5);
    }
  }

  static void updateStatusBarHeight(double height) {
    statusBarHeight = statusBarHeight == -1 ? height.toInt() : statusBarHeight;
  }

  static void updateBottomPadding(double padding) {
    bottomPadding = bottomPadding == -1 ? padding.toInt() : bottomPadding;
  }
}
