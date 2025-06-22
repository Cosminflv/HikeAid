import 'package:core/di/app_blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/utils/unit_converters.dart';
import 'package:shared/domain/sections/base_section_entity.dart';

import '../config/theme.dart';
import 'line_area_chart.dart';
import 'road_section_slider_panel.dart';
import 'route_profile_panel_bloc.dart';
import 'route_profile_panel_event.dart';
import 'route_profile_panel_state.dart';
import 'surfaces_section_slider_panel.dart';

class RouteProfilePanel extends StatelessWidget {
  final ScrollController scrollController;
  final LineAreaChartController _chartController = LineAreaChartController();
  final VoidCallback? onChartTap;
  final VoidCallback? onSurfaceTypeTap;
  final VoidCallback? onRoadTypeTap;

  final void Function(BaseSectionEntity, Color) onSelectionChanged;

  final RouteProfilePanelBloc? routeProfleBloc;

  RouteProfilePanel(
      {super.key,
      this.onChartTap,
      this.onRoadTypeTap,
      this.onSurfaceTypeTap,
      ScrollController? controller,
      required this.onSelectionChanged,
      this.routeProfleBloc})
      : scrollController = controller ?? ScrollController();

  @override
  Widget build(BuildContext context) {
    final bloc = routeProfleBloc ?? AppBlocs.routeTerrainProfileBloc;

    return Material(
      child: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<RouteProfilePanelBloc, RouteProfilePanelState>(
          buildWhen: (previous, current) => previous.terrainProfile != current.terrainProfile,
          builder: (context, state) {
            if (state.terrainProfile == null) {
              return const SizedBox.shrink();
            }
            return Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, top: 16.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Elevation Profile",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        if (onChartTap != null)
                          PlatformTextButton(
                            onPressed: onChartTap,
                            child: const Text("Details"),
                          )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onChartTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: LineAreaChart(
                        withXAxis: true,
                        withYAxis: false,
                        isInteractive: false,
                        legendLabelColor: Theme.of(context).colorScheme.onSurface,
                        points: state.terrainProfile!.getElevationSamples(10),
                        controller: _chartController,
                        steepSections: state.terrainProfile!.getSteepSections(),
                        onSelect: (a) => bloc.add(DistanceSelectedEvent(distance: a.toInt())),
                        onViewPortChanged: (leftX, rightX) =>
                            bloc.add(PathByDistancesSelectedEvent(start: leftX.floor(), end: rightX.ceil())),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        RouteProfileInformationItem(
                            icon: FontAwesomeIcons.arrowUp,
                            title: "Uphill",
                            value: convertDistance(state.totalUp, getDistanceUnit(context))),
                        RouteProfileInformationItem(
                            icon: FontAwesomeIcons.arrowDown,
                            title: "Downhill",
                            value: convertDistance(state.totalDown, getDistanceUnit(context))),
                        RouteProfileInformationItem(
                            icon: FontAwesomeIcons.caretUp,
                            title: "Highest Point",
                            value: convertDistance(
                                state.terrainProfile!.getMaxElevation().$2.toInt(), getDistanceUnit(context),
                                metersOnly: true)),
                        RouteProfileInformationItem(
                            icon: FontAwesomeIcons.caretDown,
                            title: "Lowest Point",
                            value: convertDistance(
                                state.terrainProfile!.getMinElevation().$2.toInt(), getDistanceUnit(context),
                                metersOnly: true)),
                        // RouteProfileInformationItem(
                        //     icon: FontAwesomeIcons.arrowUp, title: 'Estimated Average Speed', value: '- size')
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 0),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: onRoadTypeTap,
                      child: WaysSectionSlider(
                        isInteractive: false,
                        onDetailsTap: onRoadTypeTap,
                        sections: state.terrainProfile!.getRoadTypeSections(),
                        routeLength: state.terrainProfile!.getDistance(),
                        onSelectionChanged: onSelectionChanged,
                      ),
                    ),
                  ),
                  const Divider(height: 0),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: onSurfaceTypeTap,
                      child: SurfacesSectionSlider(
                        isInteractive: false,
                        onDetailsTap: onSurfaceTypeTap,
                        sections: state.terrainProfile!.getSurfaceSections(),
                        routeLength: state.terrainProfile!.getDistance(),
                        onSelectionChanged: onSelectionChanged,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class RouteProfileInformationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const RouteProfileInformationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 20),
          const SizedBox(width: 10),
          Text('$title: ', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
          Text(value, style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
    );
  }
}

class RouteProfilePanelHeader extends StatelessWidget {
  final VoidCallback onCloseTap;

  const RouteProfilePanelHeader({
    super.key,
    required this.onCloseTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: getThemedItemBackgroundColor(context),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.chart_bar_alt_fill, size: 30, color: Theme.of(context).colorScheme.onSurface),
                  const SizedBox(width: 8),
                  Text(
                    "Route Profile",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              IconButton(
                onPressed: onCloseTap,
                icon: Icon(
                  CupertinoIcons.xmark_circle_fill,
                  size: 30,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
