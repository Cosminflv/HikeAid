import 'package:domain/entities/view_area_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/providers/bloc_providers.dart';

class Sizes {
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
}
