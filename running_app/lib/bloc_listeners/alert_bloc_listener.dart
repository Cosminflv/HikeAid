import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/alerts/alert_bloc.dart';
import 'package:running_app/alerts/widgets/alert_panel_bottom_sheet.dart';
import 'package:running_app/alerts/alert_state.dart';
import 'package:running_app/map/map_view_event.dart';

class AlertBlocListener extends StatelessWidget {
  final Widget child;
  const AlertBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<AlertBloc, AlertState>(
        bloc: AppBlocs.alertBloc,
        listener: (context, alertState) {
          final mapBloc = AppBlocs.mapBloc;

          mapBloc.add(AddAlertsEvent(alerts: alertState.alerts));
        },
        listenWhen: (previous, current) => previous.alerts.length != current.alerts.length,
      ),
      BlocListener<AlertBloc, AlertState>(
        bloc: AppBlocs.alertBloc,
        listener: (context, alertState) {
          AlertPanelBottomSheet.show(context);
        },
        listenWhen: (previous, current) =>
            current.mapSelectedAlert != null && previous.mapSelectedAlert != current.mapSelectedAlert,
      )
    ], child: child);
  }
}
