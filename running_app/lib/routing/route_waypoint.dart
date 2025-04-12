import 'dart:typed_data';

import 'package:shared/domain/landmark_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:running_app/routing/routing_view_state.dart';
import 'package:running_app/utils/assets_utils.dart';

enum RouteWaypointType {
  departure,
  intermediateWaypoint,
  destination,
  departureAsDestination;

  static RouteWaypointType fromIndex({required int index, required int routeLength, required RouteWayType type}) {
    if (index < 0 || index >= routeLength) {
      throw RangeError('Index out of bounds for the route length');
    }

    if (index == 0) {
      return RouteWaypointType.departure;
    }

    if (index == routeLength - 1) {
      return type == RouteWayType.roundTrip ? RouteWaypointType.departureAsDestination : RouteWaypointType.destination;
    }

    return RouteWaypointType.intermediateWaypoint;
  }
}

class RouteWaypointName {
  static const departure = 'A';
  static const intermediaryPoint1 = '1';
  static const intermediaryPoint2 = '2';
  static const intermediaryPoint3 = '3';
  static const intermediaryPoint4 = '4';
  static const destination = 'B';
  static const departureAsDestination = 'A';

  static List<String> get values => [
        departure,
        intermediaryPoint1,
        intermediaryPoint2,
        intermediaryPoint3,
        intermediaryPoint4,
        destination,
        departureAsDestination
      ];

  static String fromIndex({required int index, required int routeLength, required RouteWayType type}) {
    if (index < 0 || index >= routeLength) {
      throw RangeError('Index out of bounds for the route length');
    }

    List<String> waypoints = [departure];
    if (routeLength > 2) waypoints.add(intermediaryPoint1);
    if (routeLength > 3) waypoints.add(intermediaryPoint2);
    if (routeLength > 4) waypoints.add(intermediaryPoint3);
    if (routeLength > 5) waypoints.add(intermediaryPoint4);
    waypoints.add(type == RouteWayType.roundTrip ? departureAsDestination : destination);

    if (type == RouteWayType.oneWay) {
      return waypoints[index];
    }

    return waypoints[index % routeLength];
  }

  static Future<Uint8List> getIcon(String name) async {
    final index = name[name.length - 1];
    return await assetToUint8List('assets/route/waypoint_$index.png');
  }
}

class RouteWaypoint extends Equatable {
  final String name;
  final LandmarkEntity? landmark;
  final RouteWaypointType type;

  const RouteWaypoint({this.landmark, required this.type, required this.name});

  RouteWaypoint copyWith({String? name, LandmarkEntity? landmark, RouteWaypointType? type}) =>
      RouteWaypoint(name: name ?? this.name, type: type ?? this.type, landmark: landmark ?? this.landmark);

  RouteWaypoint copyWithNullLandmark({String? name, RouteWaypointType? type}) =>
      RouteWaypoint(name: name ?? this.name, type: type ?? this.type);

  bool get isCompleted => landmark != null;

  @override
  List<Object?> get props => [landmark, type, name];
}
