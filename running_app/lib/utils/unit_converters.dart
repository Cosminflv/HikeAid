import 'package:core/di/app_blocs.dart';
import 'package:domain/settings/general_settings_entity.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertMonthToString(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return 'Invalid month';
  }
}

String convertTime(int sec) {
  int value = sec ~/ 60;
  int hours = value ~/ 60;
  int minutes = value % 60;

  if (sec < 60) {
    return '$sec s';
  }

  if (hours < 1) {
    return "$minutes min";
  }

  if (minutes == 0) {
    return "$hours hr";
  }

  final val = "$hours hr $minutes min";

  return val;
}

String convertTimeToCronometer(int sec) {
  final minutes = sec ~/ 60;
  final seconds = sec % 60;

  // Format minutes and seconds to always show two digits
  final minStr = minutes.toString().padLeft(2, '0');
  final secStr = seconds.toString().padLeft(2, '0');

  return '$minStr:$secStr';
}

String convertDistance(
  int val,
  DDistanceUnit unit, {
  withUnit = true,
  metersOnly = false,
  bool endlineBeforeUnit = false,
  int precision = 2,
}) {
  switch (unit) {
    case DDistanceUnit.km:
      return convertMetersToMetersKilometers(
          val: val,
          metersOnly: metersOnly,
          withUnit: withUnit,
          endlineBeforeUnit: endlineBeforeUnit,
          precision: precision);
    case DDistanceUnit.milesYards:
      return convertMetersToMilesYards(
          val: val,
          yardsOnly: metersOnly,
          withUnit: withUnit,
          endlineBeforeUnit: endlineBeforeUnit,
          precision: precision);

    case DDistanceUnit.milesFeet:
      return convertMetersToMilesFeet(
          val: val,
          feetOnly: metersOnly,
          withUnit: withUnit,
          endlineBeforeUnit: endlineBeforeUnit,
          precision: precision);
  }
}

String convertMetersToMetersKilometers(
    {required int val,
    required bool metersOnly,
    required bool withUnit,
    required bool endlineBeforeUnit,
    required int precision}) {
  double value;
  String unit;

  bool isMeters = false;

  if (metersOnly || val < 1000) {
    isMeters = true;
    value = val.toDouble();
    unit = "m";
  } else {
    value = val / 1000;
    unit = "km";
  }

  String result = isMeters ? value.toStringAsFixed(0) : value.toStringAsFixed(precision);

  if (withUnit) {
    result += endlineBeforeUnit ? "\n" : " ";
    result += unit;
  }

  return result;
}

String convertMetersToMilesYards(
    {required int val,
    required bool yardsOnly,
    required bool withUnit,
    required bool endlineBeforeUnit,
    required int precision}) {
  double value;
  String unit;

  const double milesThreshold = 1760;
  const double yardsThreshold = 1.093;
  final yardsValue = val * yardsThreshold;

  if (yardsValue >= milesThreshold * 0.2 && !yardsOnly) {
    value = yardsValue / milesThreshold;
    unit = "mi";
  } else {
    value = yardsValue;
    unit = "yd";
  }

  String result = yardsOnly ? value.toStringAsFixed(0) : value.toStringAsFixed(unit != 'yd' ? precision : 0);

  if (withUnit) {
    result += endlineBeforeUnit ? "\n" : " ";
    result += unit;
  }
  return result;
}

String convertMetersToMilesFeet(
    {required int val,
    required bool feetOnly,
    required bool withUnit,
    required bool endlineBeforeUnit,
    required int precision}) {
  double value;
  String unit;

  const double milesThreshold = 5280;
  const double feetThreshold = 3.28;

  final feetValue = val * feetThreshold;

  if (feetValue >= milesThreshold * 0.2 && !feetOnly) {
    value = feetValue / milesThreshold;
    unit = "mi";
  } else {
    value = feetValue;
    unit = "ft";
  }

  String result = feetOnly ? value.toStringAsFixed(0) : value.toStringAsFixed(unit != 'ft' ? precision : 0);

  if (withUnit) {
    result += endlineBeforeUnit ? "\n" : " ";
    result += unit;
  }
  return result;
}

DDistanceUnit getDistanceUnit(BuildContext context) => AppBlocs.appBloc.state.distanceUnit;

DSpeedUnit getSpeedUnit(BuildContext context) => AppBlocs.appBloc.state.speedUnit;

double mpsToKmph(double metersPerSecond) {
  double kilometersPerHour = metersPerSecond * 3.6;
  return kilometersPerHour;
}

double mpsToMph(double metersPerSecond) {
  double milesPerHour = metersPerSecond * 2.23694;
  milesPerHour = milesPerHour.roundToDouble();
  return milesPerHour;
}

int calculateElapsedTime(DateTime? startTime, DateTime? endTime) {
  if (startTime == null || endTime == null) return 0;

  Duration difference = endTime.difference(startTime);

  int seconds = difference.inSeconds;

  return seconds;
}

String convertWh(double value) {
  return "$value wh";
}

String convertSpeed(double metersPerSecond, DSpeedUnit unit) {
  switch (unit) {
    case DSpeedUnit.mPerSecond:
      return "${metersPerSecond.toStringAsFixed(1)} ";
    case DSpeedUnit.kmPerHour:
      return mpsToKmph(metersPerSecond).toStringAsFixed(1);
    case DSpeedUnit.milesPerHour:
      return mpsToMph(metersPerSecond).toStringAsFixed(1);
  }
}

String convertTimeExplicit(int sec) {
  final int value = sec ~/ 60;
  final int hours = value ~/ 60;
  final int minutes = value % 60;
  final int seconds = sec % 60;

  String hoursStr;
  String minutesStr;
  String secondsStr;

  hours < 10 ? hoursStr = '0$hours' : hoursStr = '$hours';
  minutes < 10 ? minutesStr = '0$minutes' : minutesStr = '$minutes';
  seconds < 10 ? secondsStr = '0$seconds' : secondsStr = '$seconds';

  final result = "$hoursStr:$minutesStr:$secondsStr";

  return result;
}

int convertKgToPounds(int kgValue) => kgValue ~/ 0.4535;

int convertPoundsToKg(int lbsValue) => (lbsValue * 0.4535).toInt();

String getCurrentTime({int additionalHours = 0, int additionalMinutes = 0, int additionalSeconds = 0}) {
  var now = DateTime.now();
  var updatedTime = now.add(Duration(hours: additionalHours, minutes: additionalMinutes, seconds: additionalSeconds));
  var formatter = DateFormat('HH:mm');
  return formatter.format(updatedTime);
}

String convertBytes(double byteValue) {
  if (byteValue < 1024) {
    return '$byteValue bytes';
  } else if (byteValue < 1024 * 1024) {
    double kbValue = byteValue / 1024;
    return '${kbValue.toStringAsFixed(2)} KB';
  } else if (byteValue < 1024 * 1024 * 1024) {
    double mbValue = byteValue / (1024 * 1024);
    return '${mbValue.toStringAsFixed(2)} MB';
  } else {
    double gbValue = byteValue / (1024 * 1024 * 1024);
    return '${gbValue.toStringAsFixed(2)} GB';
  }
}

String convertGramsIntoKilograms(double grams) {
  double kilograms = grams / 1000;
  return '${kilograms.toStringAsFixed(1)} kg';
}

double calculateSpeed(int distance, int time) {
  return distance / time;
}

extension HumanReadableDate on DateTime {
  String toErgonomicString() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays == 0 && day == now.day) {
      return "Today at ${DateFormat('HH:mm').format(this)}";
    } else if (difference.inDays == 1 || (difference.inDays == 0 && now.day != day)) {
      return "Yesterday at ${DateFormat('HH:mm').format(this)}";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 30) {
      return "${difference.inWeeks()} weeks ago";
    } else if (difference.inDays < 365) {
      return "${difference.inMonths()} months ago";
    } else {
      return DateFormat('dd.MM.yyyy').format(this);
    }
  }
}

extension DurationExtensions on Duration {
  int inWeeks() => (inDays / 7).floor();
  int inMonths() => (inDays / 30).floor();
}
