import 'package:flutter/widgets.dart';
import 'package:running_app/bloc_listeners/app_bloc_listener.dart';
import 'package:running_app/bloc_listeners/auth_session_bloc_listener.dart';
import 'package:running_app/bloc_listeners/location_bloc_listener.dart';
import 'package:running_app/bloc_listeners/map_bloc_listener.dart';
import 'package:running_app/bloc_listeners/navigation_bloc_listener.dart';
import 'package:running_app/bloc_listeners/routing_bloc_listener.dart';
import 'package:running_app/bloc_listeners/tour_recording_bloc_listener.dart';

class MapPageBlocListeners extends StatelessWidget {
  final Widget child;
  const MapPageBlocListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppBlocListener(
      child: AuthSessionBlocListener(
        child: LocationBlocListener(
          child: RoutingBlocListener(
            child: TourRecordingBlocListener(
              child: NavigationBlocListener(
                child: MapBlocListener(
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
