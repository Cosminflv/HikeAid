import 'package:core/di/injection_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map/map_view_bloc.dart';

class MapBlocsProvider extends StatelessWidget {
  final Widget child;
  const MapBlocsProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(value: sl.get<MapViewBloc>()),
    ], child: child);
  }
}
