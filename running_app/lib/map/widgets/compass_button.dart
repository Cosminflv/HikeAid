import 'dart:typed_data';

import 'package:core/di/injection_container.dart';
import 'package:domain/map_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map/map_view_event.dart';

import '../../providers/bloc_providers.dart';
import '../map_view_bloc.dart';
import '../map_view_state.dart';

class CompassButton extends StatefulWidget {
  const CompassButton({super.key});

  @override
  State<CompassButton> createState() => _CompassButtonState();
}

class _CompassButtonState extends State<CompassButton> {
  Uint8List? compassImage;
  Brightness? _currentBrightness;

  static const double _degreesToRadians = (3.141592653589793 / 180);

  Uint8List compassImageIcon(BuildContext context) {
    _currentBrightness = Theme.of(context).colorScheme.brightness;
    final mapPlatform = sl.get<MapPlatform>();

    if (Theme.of(context).colorScheme.brightness == Brightness.light) {
      return mapPlatform.getImage(type: ThemeType.day, width: 100, height: 100);
    }
    return mapPlatform.getImage(type: ThemeType.night, width: 100, height: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: BlocBuilder<MapViewBloc, MapViewState>(
          buildWhen: (previous, current) =>
              previous.compassAngle != current.compassAngle ||
              previous.isFollowingPosition != current.isFollowingPosition,
          builder: (context, mapState) {
            compassImage =
                (_currentBrightness == null || _currentBrightness != Theme.of(context).colorScheme.brightness)
                    ? compassImageIcon(context)
                    : compassImage;
            bool isVisible = mapState.compassAngle >= 1.0 && mapState.compassAngle <= 359;
            return AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => _handleCompassTap(context),
                  child: Transform.rotate(
                    angle: mapState.compassAngle * _degreesToRadians,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.surface),
                      child: SizedBox(width: 40, height: 40, child: Image.memory(compassImage!)),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  _handleCompassTap(BuildContext context) {
    final mapBloc = BlocProviders.map(context);

    if (mapBloc.state.isFollowPositionFixed) {
      mapBloc.add(CompassLockCameraEvent());
    } else {
      mapBloc.add(CompassAlignNorthEvent());
    }
  }
}
