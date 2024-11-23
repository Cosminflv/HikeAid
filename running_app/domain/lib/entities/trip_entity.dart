import 'package:domain/entities/route_entity.dart';

abstract class TripEntity extends RouteEntity {
  DateTime get startTime;
  DateTime get endTime;
  TripEntity({required super.distance, required super.duration, required super.waypoints, endTime});
}
