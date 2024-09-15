import 'package:core/di/injection_container.dart';
import 'package:domain/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:running_app/app/app_events.dart';
import 'package:running_app/app/app_state.dart';
import 'package:running_app/bloc_listeners/map_page_bloc_listeners.dart';
import 'package:running_app/location/location_event.dart';
import 'package:running_app/map/widgets/map_actions_buttons.dart';
import 'package:running_app/map/widgets/map_view_top_panel.dart';
import 'package:running_app/providers/bloc_providers.dart';
import 'package:running_app/utils/map_blocs_provider.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  @override
  void initState() {
    initBlocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MapBlocsProvider(
      child: MapPageBlocListeners(
        child: Scaffold(
          body: Stack(
            children: [
              Builder(builder: (context) {
                return MapWidget(
                  onMapCreated: (controller) {
                    final appBloc = BlocProviders.app(context);
                    final locationBloc = BlocProviders.location(context);

                    initMapDependecies(controller);
                    locationBloc.add(InitializeLocationEvent());
                    appBloc.add(UpdateAppStatusEvent(AppStatus.initializedMap));
                  },
                );
              }),
              const MapActionsButtons(),
              const Positioned(
                top: 20,
                child: MapViewTopPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
