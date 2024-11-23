import 'package:domain/entities/transport_means.dart';
import 'package:equatable/equatable.dart';

enum BikeType { road, cross, city, mountain }

enum TravelMode {
  fastest,
  // shortest,
  economic,
}

enum DistanceUnitType { kilometers, milesY, milesF }

enum EBikeType {
  none,
  pedelec,
  powerOnDemand;

  @override
  String toString() {
    switch (this) {
      case EBikeType.none:
        return 'None';
      case EBikeType.pedelec:
        return 'Pedelec';
      case EBikeType.powerOnDemand:
        return 'Power-On-Demand';
    }
  }
}

class RoutePreferencesEntity extends Equatable {
  final DistanceUnitType distanceUnitType;
  final DTransportMeans transportMeans;

  RoutePreferencesEntity({
    this.distanceUnitType = DistanceUnitType.kilometers,
    this.transportMeans = DTransportMeans.pedestrian,
  });
  @override
  List<Object?> get props => [
        distanceUnitType,
        transportMeans,
      ];
}

class BikeSettingsEntity extends Equatable {
  final BikeType bikeType;
  final EBikeType eBikeType;
  final TravelMode travelMode;

  final bool avoidFerries;
  final bool avoidUnpavedRoads;
  final bool ignoreRestrictionsOverTrack;

  final double bikeWeight;
  final double bikerWeight;
  final double avoidHillsFactor;

  final double auxConsumptionDay;
  final double auxConsumptionNight;

  final DistanceUnitType distanceUnitType;

  // Not serialized in preferences
  final TravelMode rangeType;
  final int? rangeValue;
  final bool hasAccurateTrackMatch; // Required for precise finger draw routing
  final bool isRange;
  final bool withTerrainProfile;
  final bool withOnlyTimeDistance;

  const BikeSettingsEntity({
    this.bikeType = BikeType.city,
    this.eBikeType = EBikeType.none,
    this.travelMode = TravelMode.fastest,
    this.avoidFerries = false,
    this.avoidUnpavedRoads = false,
    this.ignoreRestrictionsOverTrack = false,
    this.bikeWeight = 20,
    this.bikerWeight = 70,
    this.avoidHillsFactor = 5,
    this.rangeType = TravelMode.fastest,
    this.distanceUnitType = DistanceUnitType.kilometers,
    this.rangeValue,
    this.isRange = false,
    this.hasAccurateTrackMatch = false,
    this.withTerrainProfile = true,
    this.withOnlyTimeDistance = false,
    this.auxConsumptionDay = 0.0,
    this.auxConsumptionNight = 0.0,
  });

  BikeSettingsEntity copyWith({
    BikeType? bikeType,
    EBikeType? eBikeType,
    TravelMode? travelMode,
    bool? avoidFerries,
    bool? avoidUnpavedRoads,
    double? bikerWeight,
    double? bikeWeight,
    double? avoidHillsFactor,
    TravelMode? rangeType,
    DistanceUnitType? distanceUnitType,
    int? rangeValue,
    bool? isRange,
    bool? hasAccurateTrackMatch,
    bool? ignoreRestrictionsOverTrack,
    bool? withTerrainProfile,
    bool? withOnlyTimeDistance,
    double? auxConsumptionDay,
    double? auxConsumptionNight,
  }) =>
      BikeSettingsEntity(
        bikeType: bikeType ?? this.bikeType,
        eBikeType: eBikeType ?? this.eBikeType,
        travelMode: travelMode ?? this.travelMode,
        avoidFerries: avoidFerries ?? this.avoidFerries,
        avoidUnpavedRoads: avoidUnpavedRoads ?? this.avoidUnpavedRoads,
        ignoreRestrictionsOverTrack: ignoreRestrictionsOverTrack ?? this.ignoreRestrictionsOverTrack,
        bikeWeight: bikeWeight ?? this.bikeWeight,
        bikerWeight: bikerWeight ?? this.bikerWeight,
        avoidHillsFactor: avoidHillsFactor ?? this.avoidHillsFactor,
        rangeType: rangeType ?? this.rangeType,
        distanceUnitType: distanceUnitType ?? this.distanceUnitType,
        rangeValue: rangeValue ?? this.rangeValue,
        isRange: isRange ?? this.isRange,
        hasAccurateTrackMatch: hasAccurateTrackMatch ?? this.hasAccurateTrackMatch,
        withTerrainProfile: withTerrainProfile ?? this.withTerrainProfile,
        withOnlyTimeDistance: withOnlyTimeDistance ?? this.withOnlyTimeDistance,
        auxConsumptionDay: auxConsumptionDay ?? this.auxConsumptionDay,
        auxConsumptionNight: auxConsumptionNight ?? this.auxConsumptionNight,
      );

  @override
  List<Object?> get props => [
        bikeType,
        eBikeType,
        travelMode,
        avoidFerries,
        avoidUnpavedRoads,
        ignoreRestrictionsOverTrack,
        bikeWeight,
        bikerWeight,
        avoidHillsFactor,
        distanceUnitType,
        rangeType,
        rangeValue,
        hasAccurateTrackMatch,
        isRange,
        withTerrainProfile,
        withOnlyTimeDistance,
        auxConsumptionDay,
        auxConsumptionNight,
      ];
}
