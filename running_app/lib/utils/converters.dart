import 'package:domain/entities/authentication_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String convertFailTypeToString(BuildContext context, AuthenticationFailType type) {
  switch (type) {
    case AuthenticationFailType.invalidCredentials:
      return AppLocalizations.of(context)!.invalidCredentials;
    case AuthenticationFailType.timeout:
      return AppLocalizations.of(context)!.requestTimeout;
    case AuthenticationFailType.noConnection:
      return AppLocalizations.of(context)!.noInternetConnection;
    default:
      return AppLocalizations.of(context)!.tryAgain;
  }
}
