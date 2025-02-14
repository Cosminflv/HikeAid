import 'package:another_flushbar/flushbar.dart';
import 'package:core/di/app_blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/alerts/alert_bloc.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/alerts/alert_state.dart';
import 'package:running_app/friendships/friendships_view_events.dart';
import 'package:running_app/internet_connection/internet_connection_bloc.dart';
import 'package:running_app/internet_connection/internet_connection_page.dart';
import 'package:running_app/utils/session_utils.dart';

class InternetConnectionChecker extends StatefulWidget {
  final Widget child;
  final bool canInteract;
  final VoidCallback? onInternetConnectionRestored;
  final bool showFullPage;

  const InternetConnectionChecker({
    super.key,
    required this.child,
    this.canInteract = false,
    this.onInternetConnectionRestored,
    this.showFullPage = true,
  });

  @override
  State<InternetConnectionChecker> createState() => _InternetConnectionCheckerState();
}

class _InternetConnectionCheckerState extends State<InternetConnectionChecker> {
  static Flushbar? bar;
  static Flushbar? alertBar;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bar = Flushbar(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      animationDuration: const Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(15),
      message: AppLocalizations.of(context)!.noInternetConnection,
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      isDismissible: false,
      onTap: (flushbar) => flushbar.dismiss(),
      icon: const Icon(
        CupertinoIcons.wifi_slash,
        color: Colors.white,
      ),
      titleText: Text(
        AppLocalizations.of(context)!.connectionError,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
      ),
      messageText: Text(
        AppLocalizations.of(context)!.checkInternetConnection,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
      ),
    );
  }

  void _showAlertNotification(BuildContext context, String message, {Color backgroundColor = Colors.green}) {
    //alertBar?.dismiss().then((_) {
    alertBar = Flushbar(
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
    //});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool willPop) async {
        if (willPop) {
          await bar?.dismiss();
          await alertBar?.dismiss();
        }
      },
      child: MultiBlocListener(
        listeners: [
          // Internet Connection Bloc
          BlocListener<InternetConnectionBloc, bool>(
            listener: (context, hasInternetConnection) {
              if (hasInternetConnection) {
                widget.onInternetConnectionRestored?.call();
                AppBlocs.friendships.add(InitializeNotificationService(userId: getSession(context)!.user.id));
                AppBlocs.alertBloc.add(RegisterAlertsSubscription());
              } else {
                AppBlocs.friendships.add(CloseNotificationService());
                AppBlocs.alertBloc.add(CloseAlertsSubscription());
              }

              // Skip showing Flushbar if `showFullPage` is enabled
              if (widget.showFullPage) return;

              if (!hasInternetConnection) {
                if (bar != null && !bar!.isShowing()) {
                  bar!.show(context);
                }
              } else {
                bar?.dismiss();
              }
            },
          ),

          // Alert Bloc - Handle notifications for alerts
          BlocListener<AlertBloc, AlertState>(
            listener: (context, state) {
              if (state.hasAdded) {
                _showAlertNotification(context, "Successfully added alert!");
                AppBlocs.alertBloc.add(ResetStateBooleansEvent());
              } else if (state.hasConfirmed) {
                _showAlertNotification(context, "Successfully confirmed alert!");
              } else if (state.hasAddedToPending) {
                _showAlertNotification(
                  context,
                  "Currently offline, the alert will upload when back online.",
                  backgroundColor: Colors.orange,
                );
                AppBlocs.alertBloc.add(ResetStateBooleansEvent());
              }
            },
          ),
        ],
        child: BlocBuilder<InternetConnectionBloc, bool>(
          builder: (context, hasInternetConnection) {
            return Stack(
              children: [
                Positioned.fill(
                  child: AbsorbPointer(
                    absorbing: widget.canInteract ? false : !hasInternetConnection,
                    child: widget.child,
                  ),
                ),
                if (!hasInternetConnection && widget.showFullPage) const NoInternetConnectionPage(),
              ],
            );
          },
        ),
      ),
    );
  }
}
