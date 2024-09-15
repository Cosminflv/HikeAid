import 'package:flutter/widgets.dart';
import 'package:running_app/bloc_listeners/app_bloc_listener.dart';
import 'package:running_app/bloc_listeners/location_bloc_listener.dart';

class MapPageBlocListeners extends StatelessWidget {
  final Widget child;
  const MapPageBlocListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppBlocListener(
      child: LocationBlocListener(child: child),
    );
  }
}
