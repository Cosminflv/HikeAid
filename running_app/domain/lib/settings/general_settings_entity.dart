import 'package:equatable/equatable.dart';

enum DMapLabelsLanguage {
  automatic,
  inLocalLanguage;
}

enum DDistanceUnit {
  km,
  milesYards,
  milesFeet;
}

enum DSpeedUnit { mPerSecond, kmPerHour, milesPerHour }

class GeneralSettingsEntity extends Equatable {
  const GeneralSettingsEntity(
      {this.labelsLanguage = DMapLabelsLanguage.automatic,
      this.distanceUnit = DDistanceUnit.km,
      this.speedUnit = DSpeedUnit.kmPerHour,
      this.allowMobileData = true});

  final DMapLabelsLanguage labelsLanguage;
  final DDistanceUnit distanceUnit;
  final DSpeedUnit speedUnit;
  final bool allowMobileData;

  GeneralSettingsEntity copyWith(
          {DMapLabelsLanguage? labelsLanguage,
          DDistanceUnit? distanceUnit,
          DSpeedUnit? speedUnit,
          bool? allowMobileData}) =>
      GeneralSettingsEntity(
          labelsLanguage: labelsLanguage ?? this.labelsLanguage,
          distanceUnit: distanceUnit ?? this.distanceUnit,
          speedUnit: speedUnit ?? this.speedUnit,
          allowMobileData: allowMobileData ?? this.allowMobileData);

  @override
  List<Object?> get props => [labelsLanguage, distanceUnit, speedUnit, allowMobileData];
}
