import 'package:running_app/alerts/alert_bloc.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/alerts/alert_panel.dart';
import 'package:running_app/alerts/alert_state.dart';

import 'package:core/di/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/map/map_view_event.dart';

class AlertPanelBottomSheet {
  static PersistentBottomSheetController? _controller;
  static PersistentBottomSheetController? show(BuildContext context) {
    _controller = showBottomSheet(
      context: context,
      enableDrag: false,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      ),
      builder: (context) => BlocBuilder<AlertBloc, AlertState>(
        bloc: AppBlocs.alertBloc,
        buildWhen: (previous, current) =>
            previous.mapSelectedAlert != current.mapSelectedAlert && current.mapSelectedAlert != null,
        builder: (context, alertState) {
          return AlertPanel(
            alert: alertState.mapSelectedAlert!,
            onCloseTap: () => _handleOnCloseTap(context),
            onInvalidAlertTap: () => AppBlocs.alertBloc.add(InvalidateAlertEvent(alertState.mapSelectedAlert!.id)),
            onValidAlertTap: () => AppBlocs.alertBloc.add(ConfirmAlertEvent(alertState.mapSelectedAlert!.id)),
          );
        },
      ),
    );

    return _controller;
  }

  static bool get isOpen => _controller != null;

  static void close() {
    if (_controller != null) {
      _controller!.close();
    }
  }

  static void _handleOnCloseTap(BuildContext context) {
    final alertBloc = AppBlocs.alertBloc;
    final mapBloc = AppBlocs.mapBloc;
    mapBloc.add(UnselectAlertEvent());
    alertBloc.add(AlertUnselectedEvent());
    Navigator.of(context).pop();
  }
}
