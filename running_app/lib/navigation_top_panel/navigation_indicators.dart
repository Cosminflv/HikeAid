import 'package:domain/settings/general_settings_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/location/location_bloc.dart';
import 'package:running_app/location/location_state.dart';
import 'package:running_app/navigation/navigation_view_bloc.dart';
import 'package:running_app/navigation/navigation_view_state.dart';
import 'package:running_app/utils/unit_converters.dart';

// class AverageSpeedIndicator extends StatelessWidget {
//   final bool isExpanded;

//   const AverageSpeedIndicator({super.key, this.isExpanded = false});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TourRecordingBloc, TourRecordingState>(
//       builder: (context, state) {
//         return NavigationIndicator(
//           speed: state.averageSpeed != null ? convertSpeed(state.averageSpeed!, DSpeedUnit.kmPerHour) : '-',
//           label: AppLocalizations.of(context)!.averageSpeed,
//           color: Theme.of(context).colorScheme.surfaceContainerHighest,
//           measurementUnit: ' km/h',
//           isExpanded: isExpanded,
//         );
//       },
//     );
//   }
// }

class CurrentSpeedIndicator extends StatelessWidget {
  final bool isExpanded;

  const CurrentSpeedIndicator({super.key, this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      buildWhen: (previous, current) => previous.currentPosition?.speed != current.currentPosition?.speed,
      builder: (context, state) {
        return NavigationIndicator(
          speed: (state.currentPosition == null)
              ? '-'
              : convertSpeed(state.currentPosition!.speed, DSpeedUnit.kmPerHour).toString(),
          label: AppLocalizations.of(context)!.currentSpeed,
          color: Theme.of(context).colorScheme.surface,
          measurementUnit: ' km/h',
          isExpanded: isExpanded,
        );
      },
    );
  }
}

class TraveledDistanceIndicator extends StatelessWidget {
  final bool isExpanded;

  const TraveledDistanceIndicator({super.key, this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationViewBloc, NavigationViewState>(
      builder: (context, state) {
        String distanceString = convertDistance(state.traveledDistance, DDistanceUnit.km).toString();
        List<String> parts = distanceString.split(' ');
        String number = parts[0];
        String unit = parts[1];

        return NavigationIndicator(
          speed: (number == '0') ? '-' : number,
          label: "Traveled", //TODO: Change to internationalization
          color: Theme.of(context).colorScheme.surface,
          measurementUnit: ' $unit',
          isExpanded: isExpanded,
        );
      },
    );
  }
}

class RemainingDistanceIndicator extends StatelessWidget {
  final bool isExpanded;

  const RemainingDistanceIndicator({super.key, this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationViewBloc, NavigationViewState>(
      builder: (context, state) {
        String? distanceString = state.currentInstruction != null
            ? convertDistance(state.currentInstruction!.remainingDistance, DDistanceUnit.km)
            : '0 m';
        List<String> parts = distanceString.split(' ');
        String number = parts[0];
        String unit = parts[1];

        return NavigationIndicator(
          speed: (number == '0') ? '-' : number,
          label: "Remaining", //TODO: Change to internationalization
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          measurementUnit: ' $unit',
          isExpanded: isExpanded,
        );
      },
    );
  }
}

class RemainingDurationIndicator extends StatelessWidget {
  final bool isExpanded;

  const RemainingDurationIndicator({super.key, this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationViewBloc, NavigationViewState>(
      builder: (context, state) {
        String? durationString;
        if (state.currentInstruction != null) {
          if (convertTime(state.currentInstruction!.remainingDuration) == '0 min' &&
              state.currentInstruction!.remainingDuration > 0) {
            durationString = convertTimeToCronometer(state.currentInstruction!.remainingDuration);
          } else {
            durationString = convertTime(state.currentInstruction!.remainingDuration);
          }
        } else {
          durationString = '0';
        }

        List<String> parts = durationString.split(' ');
        String number = parts[0];
        String unit = parts.length > 1 ? parts[1] : '';

        return NavigationIndicator(
          speed: (number == '0') ? '-' : number,
          label: "Remaining", //TODO: Change to internationalization
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          measurementUnit: ' $unit',
          isExpanded: isExpanded,
        );
      },
    );
  }
}

// class MotionIndicator extends StatelessWidget {
//   final bool isExpanded;

//   const MotionIndicator({super.key, this.isExpanded = false});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TourRecordingBloc, TourRecordingState>(
//       builder: (context, state) {
//         String? durationString;
//         if (state.timeInMotion != null) {
//           if (convertTime(state.timeInMotion!) == '0 min' && state.timeInMotion! > 0) {
//             durationString = convertTimeToCronometer(state.timeInMotion!);
//           } else {
//             durationString = convertTime(state.timeInMotion!);
//           }
//         } else {
//           durationString = '0';
//         }

//         List<String> parts = durationString.split(' ');
//         String number = parts[0];
//         String unit = parts.length > 1 ? parts[1] : '';

//         return NavigationIndicator(
//           speed: (number == '0') ? '-' : number,
//           label: AppLocalizations.of(context)!.inMotion,
//           color: Theme.of(context).colorScheme.surface,
//           measurementUnit: ' $unit',
//           isExpanded: isExpanded,
//         );
//       },
//     );
//   }
// }

// class CurrentElevationIndicator extends StatelessWidget {
//   final bool isExpanded;

//   const CurrentElevationIndicator({super.key, this.isExpanded = false});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RouteProfilePanelBloc, RouteProfilePanelState>(
//       builder: (context, profileState) {
//         return BlocBuilder<NavigationViewBloc, NavigationViewState>(
//           builder: (context, navigationState) {
//             String? distanceString = profileState.terrainProfile != null
//                 ? convertDistance(profileState.terrainProfile!.getElevation(navigationState.traveledDistance).toInt(),
//                         DDistanceUnit.km,
//                         metersOnly: true)
//                     .split(' ')[0]
//                 : '-';
//             return NavigationIndicator(
//               speed: distanceString,
//               label: AppLocalizations.of(context)!.currentElevation,
//               color: Theme.of(context).colorScheme.surfaceContainerHighest,
//               measurementUnit: ' m',
//               isExpanded: isExpanded,
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class TerrainProfileIndicator extends StatelessWidget {
//   const TerrainProfileIndicator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final chartController = LineAreaChartController();
//     return Container(
//       width: MediaQuery.of(context).size.width / 2,
//       color: Theme.of(context).colorScheme.surface,
//       padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20.0, top: 20.0),
//       child: BlocBuilder<RouteProfilePanelBloc, RouteProfilePanelState>(
//         builder: (context, profileState) {
//           if (profileState.terrainProfile == null) return const SizedBox.shrink();

//           final elevationSamples = profileState.terrainProfile!.getElevationSamples(100);
//           return BlocListener<NavigationViewBloc, NavigationViewState>(
//             listener: (BuildContext context, NavigationViewState navigationState) {
//               if (chartController.setCurrentHighlight != null) {
//                 chartController.setCurrentHighlight!(navigationState.traveledDistance.toDouble());
//               }
//             },
//             child: AbsorbPointer(
//               child: LineAreaChart(
//                 withXAxis: false,
//                 withYAxis: false,
//                 isInteractive: true,
//                 withTopIcons: false,
//                 legendLabelColor: Theme.of(context).colorScheme.onSurface,
//                 points: elevationSamples,
//                 steepSections: const [],
//                 controller: chartController,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class NavigationIndicator extends StatelessWidget {
  final String speed;
  final String label;
  final String measurementUnit;

  final Color color;

  final bool isExpanded;

  const NavigationIndicator({
    super.key,
    required this.speed,
    required this.label,
    required this.color,
    required this.measurementUnit,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      color: (isExpanded) ? Theme.of(context).colorScheme.surface : color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: (isExpanded) ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
        children: [
          if (!isExpanded)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: speed,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: measurementUnit,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ]))
              ],
            ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (isExpanded)
            Text(
              speed,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 85),
            ),
          if (isExpanded)
            Text(
              measurementUnit,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
        ],
      ),
    );
  }
}
