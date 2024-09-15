import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/app/app_bloc.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/map/map_view_event.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/utils/sizes.dart';

class AppBlocListener extends StatelessWidget {
  final Widget child;
  const AppBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<AppBloc, AppState>(
        bloc: BlocProviders.app(context),
        listener: (context, appState) {
          final mapBloc = BlocProviders.map(context);

          mapBloc.add(InitMapViewEvent(
            centerOfVisibleAreaFunction: () => Sizes.getCenterOfVisibleArea(context),
          ));
        },
        listenWhen: (previous, current) =>
            previous.status == AppStatus.intializedSDK && current.status == AppStatus.initializedMap,
      ),
    ], child: child);
  }
}
