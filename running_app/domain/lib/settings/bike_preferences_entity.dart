import 'package:domain/entities/transport_means.dart';
import 'package:equatable/equatable.dart';

enum TravelMode {
  fastest,
  // shortest,
  economic,
}

enum DistanceUnitType { kilometers, milesY, milesF }

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
