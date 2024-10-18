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

String convertMonthToString(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "Invalid"; // Handle invalid month inputs
  }
}
