import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/config/theme.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_state.dart';
import 'package:running_app/map/widgets/follow_position_button.dart';

class MapActionsButtons extends StatelessWidget {
  const MapActionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state.isNavigating) return const SizedBox.shrink();
        return BlocBuilder<MapViewBloc, MapViewState>(
          builder: (context, mapState) {
            if (!mapState.isFollowingPosition) {
              return AnimatedPositioned(
                duration: Durations.short1,
                bottom: 10.0,
                right: 0,
                child: Container(
                  height: 50,
                  width: 40,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: getAppbarColor(context),
                  ),
                  child: const Column(
                    children: [
                      Expanded(child: FollowPositionButton()),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
