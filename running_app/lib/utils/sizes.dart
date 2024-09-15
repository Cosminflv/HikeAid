import 'package:domain/entities/view_area_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/providers/bloc_providers.dart';

class Sizes {
  static int statusBarHeight = -1;
  static int bottomPadding = -1;

  static PointEntity<double> getCenterOfVisibleArea(BuildContext context) {
    final appStatus = BlocProviders.app(context).state.status;
    switch (appStatus) {
      case AppStatus.uninitialized:
      case AppStatus.intializedSDK:
      case AppStatus.drawing:
      case AppStatus.initializedMap:
        return const PointEntity(x: 0.5, y: 0.5);
      case AppStatus.routing:
      case AppStatus.navigation:
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
