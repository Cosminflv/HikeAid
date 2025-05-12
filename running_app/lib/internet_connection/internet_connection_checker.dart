import 'package:another_flushbar/flushbar.dart';
import 'package:core/di/app_blocs.dart';
import 'package:domain/entities/connectivity_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:running_app/alerts/alert_events.dart';
import 'package:running_app/friendships/friendships_view_events.dart';
import 'package:running_app/internet_connection/device_info_bloc.dart';
import 'package:running_app/internet_connection/device_info_state.dart';
import 'package:running_app/user_profile/user_profile_view_event.dart';
import 'package:running_app/user_profile/user_profile_view_state.dart';
import 'package:running_app/utils/session_utils.dart';

import 'internet_connection_page.dart';

class InternetConnectionAbsorbPointer extends StatelessWidget {
  final Widget child;

  const InternetConnectionAbsorbPointer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceInfoBloc, DeviceInfoState>(
      builder: (context, deviceInfoState) => AbsorbPointer(
        absorbing: !(deviceInfoState.connectivityStatus == DConnectivityStatus.ethernet ||
            deviceInfoState.connectivityStatus == DConnectivityStatus.mobile ||
            deviceInfoState.connectivityStatus == DConnectivityStatus.wifi),
        //!hasInternetConnection,
        child: child,
      ),
    );
  }
}

// ignore: must_be_immutable
class InternetConnectionChecker extends StatefulWidget {
  final Widget child;
  final bool canInteract;
  final VoidCallback? onInternetConnectionRestored;
  final bool showFullPage;

  const InternetConnectionChecker(
      {super.key,
      required this.child,
      this.canInteract = false,
      this.onInternetConnectionRestored,
      this.showFullPage = true});

  @override
  State<InternetConnectionChecker> createState() => _InternetConnectionCheckerState();
}

class _InternetConnectionCheckerState extends State<InternetConnectionChecker> {
  static Flushbar? bar;

  @override
  void didChangeDependencies() {
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
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (willPop, _) async {
        await bar?.dismiss();
      },
      child: BlocConsumer<DeviceInfoBloc, DeviceInfoState>(
        listener: (context, deviceInfoState) {
          if (deviceInfoState.connectivityStatus == DConnectivityStatus.ethernet ||
              deviceInfoState.connectivityStatus == DConnectivityStatus.mobile ||
              deviceInfoState.connectivityStatus == DConnectivityStatus.wifi &&
                  widget.onInternetConnectionRestored != null) {
            widget.onInternetConnectionRestored!();
          }

          if (deviceInfoState.connectivityStatus == DConnectivityStatus.ethernet ||
              deviceInfoState.connectivityStatus == DConnectivityStatus.mobile ||
              deviceInfoState.connectivityStatus == DConnectivityStatus.wifi) {
            AppBlocs.friendships.add(InitializeNotificationService(userId: getSession(context)!.user.id));
            AppBlocs.alertBloc.add(RegisterAlertsSubscription(getSession(context)!.user.id));
            final userProfileBloc = AppBlocs.userProfileBloc;
            if (userProfileBloc.state is InitialProfileState || userProfileBloc.state is UserProfileLoadFailState) {
              userProfileBloc.add(FetchUserProfileEvent(userId: getSession(context)!.user.id));
            }
          } else {
            AppBlocs.friendships.add(CloseNotificationService());
            AppBlocs.alertBloc.add(CloseAlertsSubscription());
          }

          if (widget.showFullPage) return;

          if (bar != null && bar!.isShowing()) {
            bar!.dismiss().then((_) {
              if (!(deviceInfoState.connectivityStatus == DConnectivityStatus.ethernet ||
                  deviceInfoState.connectivityStatus == DConnectivityStatus.mobile ||
                  deviceInfoState.connectivityStatus == DConnectivityStatus.wifi)) {
                bar!.show(context);
              }
            });
          } else if (!(deviceInfoState.connectivityStatus == DConnectivityStatus.ethernet ||
              deviceInfoState.connectivityStatus == DConnectivityStatus.mobile ||
              deviceInfoState.connectivityStatus == DConnectivityStatus.wifi)) {
            bar!.show(context);
          }
        },
        builder: (context, deviceInfoState) => Stack(
          children: [
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: widget.canInteract
                    ? false
                    : !(deviceInfoState.connectivityStatus == DConnectivityStatus.ethernet ||
                        deviceInfoState.connectivityStatus == DConnectivityStatus.mobile ||
                        deviceInfoState.connectivityStatus == DConnectivityStatus.wifi),
                child: widget.child,
              ),
            ),
            if (!(deviceInfoState.connectivityStatus == DConnectivityStatus.ethernet ||
                    deviceInfoState.connectivityStatus == DConnectivityStatus.mobile ||
                    deviceInfoState.connectivityStatus == DConnectivityStatus.wifi) &&
                widget.showFullPage)
              const NoInternetConnectionPage()
          ],
        ),
      ),
    );
  }
}
