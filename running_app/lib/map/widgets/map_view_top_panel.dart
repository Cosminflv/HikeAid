import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/map/map_view_bloc.dart';
import 'package:running_app/map/map_view_state.dart';
import 'package:running_app/map/widgets/compass_button.dart';

class MapViewTopPanel extends StatelessWidget {
  const MapViewTopPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<MapViewBloc, MapViewState>(
            builder: (context, mapState) {
              if (mapState.isFollowingPosition) return const SizedBox.shrink();
              return const CompassButton();
            },
          ),
        ],
      );
    });
  }
}
