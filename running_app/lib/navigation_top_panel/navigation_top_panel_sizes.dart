import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';

class NavigationTopPanelSizes {
  static double currentInstructionPanelHeight = 100.0;
  static double speedIndicatorPanelHeight = 100.0;

  static double panelHeight(BuildContext context) {
    final navigationState = AppBlocs.navigationBloc.state;
    final locationState = AppBlocs.locationBloc.state;

    if (locationState.currentPosition != null && navigationState.currentInstruction != null) {
      return currentInstructionPanelHeight + speedIndicatorPanelHeight;
    } else if (locationState.currentPosition != null) {
      return speedIndicatorPanelHeight;
    }
    return currentInstructionPanelHeight;
  }
}
