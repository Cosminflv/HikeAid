import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/alerts/alert_bloc.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/alerts/alert_state.dart';

class AlertNotificationHandler extends StatefulWidget {
  final Widget child;

  const AlertNotificationHandler({
    super.key,
    required this.child,
  });

  @override
  State<AlertNotificationHandler> createState() => _AlertNotificationHandlerState();
}

class _AlertNotificationHandlerState extends State<AlertNotificationHandler> {
  Flushbar? _alertBar;

  void _showAlertNotification(BuildContext context, String message, {Color backgroundColor = Colors.green}) {
    //_alertBar?.dismiss().then((_) {
    _alertBar = Flushbar(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      animationDuration: const Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(15),
      message: message,
      backgroundColor: backgroundColor,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 5),
      isDismissible: true,
      onTap: (flushbar) => flushbar.dismiss(),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      titleText: Text(
        "Notification",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
      ),
    )..show(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          await _alertBar?.dismiss();
        }
      },
      child: BlocListener<AlertBloc, AlertState>(
        listener: (context, state) {
          if (state.hasAdded) {
            _showAlertNotification(context, "Alert added successfully");
            context.read<AlertBloc>().add(ResetStateBooleansEvent());
          } else if (state.hasConfirmed) {
            _showAlertNotification(context, "Successfully confirmed alert!");
          } else if (state.hasAddedToPending) {
            _showAlertNotification(
              context,
              "Currently offline, the alert will upload when back online.",
              backgroundColor: Colors.orange,
            );

            context.read<AlertBloc>().add(ResetStateBooleansEvent());
          }
        },
        child: widget.child,
      ),
    );
  }
}
