import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/location/location_state.dart';
import 'package:running_app/navigation/navigation_view_bloc.dart';
import 'package:running_app/navigation/navigation_view_state.dart';
import 'package:running_app/navigation_top_panel/navigation_gps_disabled_panel.dart';
import 'package:running_app/navigation_top_panel/navigation_indications_panel.dart';
import 'package:running_app/navigation_top_panel/navigation_indicators.dart';
import 'package:running_app/navigation_top_panel/navigation_informations.dart';
import 'package:running_app/navigation_top_panel/navigation_top_panel_sizes.dart';

class NavigationTopPanel extends StatefulWidget {
  final int totalDistance;
  final int totalDuration;
  final double topPadding;

  const NavigationTopPanel({
    super.key,
    required this.totalDistance,
    required this.totalDuration,
    required this.topPadding,
  });

  @override
  NavigationTopPanelState createState() => NavigationTopPanelState();
}

class NavigationTopPanelState extends State<NavigationTopPanel> with SingleTickerProviderStateMixin {
  int _selectedIndex = -1;

  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationViewBloc, NavigationViewState>(
      builder: (context, navigationState) {
        return BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: NavigationTopPanelSizes.panelHeight(context) + widget.topPadding,
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    children: [
                      SizedBox(height: widget.topPadding),
                      if (navigationState.currentInstruction != null || locationState.currentPosition == null)
                        Container(
                          color: Theme.of(context).colorScheme.primary,
                          height: 100,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: (navigationState.currentInstruction != null && locationState.currentPosition != null)
                              ? const NavigationIndicationsPanel()
                              : (locationState.currentPosition == null)
                                  ? const GpsDisabledPanel()
                                  : const SizedBox.shrink(),
                        ),
                      if (locationState.currentPosition != null)
                        GestureDetector(
                          onTap: () => setState(() {
                            _selectedIndex = -1;
                          }),
                          child: NavigationInformationsPanel(
                            onItemTap: (index) => setState(() {
                              _selectedIndex = index;
                              animationController.forward();
                            }),
                          ),
                        )
                    ],
                  ),
                ),
                if (navigationState.currentInstruction != null && locationState.currentPosition != null)
                  Positioned.fill(
                    top: widget.topPadding,
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Transform.scale(
                            scaleY: animation.value, alignment: Alignment.bottomCenter, child: child);
                      },
                      child: GestureDetector(
                        onTap: () => animationController.reverse().then((value) {
                          setState(() {
                            _selectedIndex = -1;
                          });
                        }),
                        child: _getSelectedItem(_selectedIndex),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _getSelectedItem(int index) {
    if (index == -1) return const SizedBox.shrink();
    if (index == 0) return const CurrentSpeedIndicator(isExpanded: true);
    //if (index == 1) return const AverageSpeedIndicator(isExpanded: true);
    if (index == 2) return const TraveledDistanceIndicator(isExpanded: true);
    if (index == 3) return const RemainingDistanceIndicator(isExpanded: true);
    //if (index == 6) return const MotionIndicator(isExpanded: true);
    if (index == 4) return const RemainingDurationIndicator(isExpanded: true);
    //if (index == 8) return const TerrainProfileIndicator();
    //return const CurrentElevationIndicator(isExpanded: true);
    return const SizedBox.shrink();
  }
}
