import 'package:core/di/app_blocs.dart';
import 'package:core/di/injection_container.dart';
import 'package:domain/entities/landmark_store_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/landmark_store/landmark_store_bloc.dart';
import 'package:running_app/map/map_view_bloc.dart';

class MapBlocsProvider extends StatelessWidget {
  final Widget child;
  const MapBlocsProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(value: sl.get<MapViewBloc>()),
      BlocProvider.value(value: AppBlocs.settingsViewBloc),
      BlocProvider.value(value: AppBlocs.routingBloc),
      BlocProvider.value(value: AppBlocs.navigationBloc),
      BlocProvider.value(value: AppBlocs.navigationInstructionBloc),
      BlocProvider.value(value: sl.get<LandmarkStoreBloc>(instanceName: DLandmarkStoreType.searchHistory.name)),
      BlocProvider.value(value: AppBlocs.mapStylesBloc),
    ], child: child);
  }
}
