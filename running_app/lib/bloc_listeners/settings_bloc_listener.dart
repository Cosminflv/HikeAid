import 'package:core/di/app_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map_styles/map_styles_panel_events.dart';
import 'package:running_app/settings/settings_view_bloc.dart';
import 'package:running_app/settings/settings_view_state.dart';

class SettingsBlocListener extends StatefulWidget {
  final Widget child;

  const SettingsBlocListener({super.key, required this.child});

  @override
  State<SettingsBlocListener> createState() => _SettingsBlocListenerState();
}

class _SettingsBlocListenerState extends State<SettingsBlocListener> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<SettingsViewBloc, SettingsViewState>(
        listener: (context, state) {
          AppBlocs.mapStylesBloc.add(InitLocalMapStylesEvent(state.prefferedMapStylePath));
        },
        listenWhen: (prev, curr) => prev.prefferedMapStylePath != curr.prefferedMapStylePath,
      ),
      // AppBloc when receiving first screen coordinates
      // BlocListener<SettingsBloc, SettingsState>(
      //   listener: (context, settingsState) {
      //     _mapBloc.add(CenterOnCoordinatesEvent(settingsState.screenCenterCoordinates));
      //   },
      //   listenWhen: (previous, current) => previous.isInitialized != current.isInitialized,
      // ),
      // AppBloc when application is initialized (Map is created)
    ], child: widget.child);
  }
}
