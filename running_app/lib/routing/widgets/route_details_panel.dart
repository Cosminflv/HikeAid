import 'package:core/di/app_blocs.dart';
import 'package:domain/settings/general_settings_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/map/map_view_bloc.dart';

import '../../../map/map_view_state.dart';
import '../../../utils/unit_converters.dart';

class RouteDetailsPanel extends StatelessWidget {
  final bool withDivider;
  final VoidCallback? onItemTap;
  const RouteDetailsPanel({super.key, this.withDivider = true, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapViewBloc, MapViewState>(
      bloc: AppBlocs.mapBloc,
      builder: (context, state) => state.mapSelectedRoute != null
          ? Container(
              color: Theme.of(context).colorScheme.surface,
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RouteDetailsItem(
                          label: convertTime(state.mapSelectedRoute!.duration),
                          icon: FontAwesomeIcons.clock,
                          onTap: onItemTap,
                        ),
                        if (withDivider)
                          const VerticalDivider(
                            width: 0,
                            thickness: 0.25,
                            color: Colors.grey,
                          ),
                        RouteDetailsItem(
                          label: convertDistance(state.mapSelectedRoute!.distance, DDistanceUnit.km),
                          icon: FontAwesomeIcons.arrowsLeftRight,
                          onTap: onItemTap,
                        ),
                        if (withDivider)
                          const VerticalDivider(
                            width: 0,
                            thickness: 0.25,
                            color: Colors.grey,
                          ),
                        RouteDetailsItem(
                          label: convertDistance(state.mapSelectedRoute!.totalUp, DDistanceUnit.km),
                          icon: FontAwesomeIcons.arrowUp,
                          onTap: onItemTap,
                        ),
                        if (withDivider)
                          const VerticalDivider(
                            width: 0,
                            thickness: 0.25,
                            color: Colors.grey,
                          ),
                        RouteDetailsItem(
                          label: convertDistance(state.mapSelectedRoute!.totalDown, DDistanceUnit.km),
                          icon: FontAwesomeIcons.arrowDown,
                          onTap: onItemTap,
                        ),
                      ],
                    ),
                  ),
                  if (withDivider)
                    const Divider(
                      height: 0,
                      thickness: 0.25,
                      color: Colors.grey,
                    )
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class RouteDetailsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const RouteDetailsItem({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }
}
