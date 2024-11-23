import 'package:domain/settings/general_settings_entity.dart';

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

  if (yardsValue > milesThreshold * 0.2 && !yardsOnly) {
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

  if (feetValue > milesThreshold * 0.2 && !feetOnly) {
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

String convertDuration(int seconds) {
  int hours = seconds ~/ 3600; // Number of whole hours
  int minutes = (seconds % 3600) ~/ 60; // Number of whole minutes

  String hoursText = (hours > 0) ? '$hours h ' : ''; // Hours text
  String minutesText = '$minutes min'; // Minutes text

  return hoursText + minutesText;
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
