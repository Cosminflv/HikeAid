import 'package:data/models/coordinates_entity_impl.dart';

import 'package:domain/entities/tour_entity.dart';
import 'package:xml/xml.dart' as xml;

class GPXRoutePoint {
  final double lat;
  final double lon;
  final String? desc;

  GPXRoutePoint({required this.lat, required this.lon, this.desc});

  @override
  String toString() {
    return 'GPXRoutePoint(lat: $lat, lon: $lon, desc: $desc)';
  }
}

class GPXTrackPoint {
  final CoordinatesWithTimestamp coordinates;
  final double? elevation;
  final double? speed;
  final double? hdop;
  final double? vdop;

  GPXTrackPoint({required this.coordinates, this.elevation, this.speed, this.hdop, this.vdop});

  @override
  String toString() {
    return 'GPXTrackPoint(lat: ${coordinates.latLng.latitude}, lon: ${coordinates.latLng.longitude}, ele: $elevation)';
  }
}

class GPXTrack {
  final String? name;
  final int? travelTimeSec;
  final int? travelDistanceM;
  final List<GPXTrackPoint> trackPoints;

  GPXTrack({
    this.name,
    this.travelTimeSec,
    this.travelDistanceM,
    required this.trackPoints,
  });

  @override
  String toString() {
    return 'GPXTrack(name: $name, travelTimeSec: $travelTimeSec, travelDistanceM: $travelDistanceM, trackPoints: $trackPoints)';
  }
}

class CustomGPXParser {
  List<GPXRoutePoint> routePoints = [];
  List<GPXTrack> tracks = [];

  CustomGPXParser(String gpxData) {
    try {
      final document = xml.XmlDocument.parse(gpxData);
      _parseRoutes(document);
      _parseTracks(document);
    } catch (e) {
      routePoints = [];
      tracks = [];
    }
  }

  // Parsing the routes (rte -> rtept)
  void _parseRoutes(xml.XmlDocument document) {
    final routePointsElements = document.findAllElements('rtept');
    for (final rtept in routePointsElements) {
      final lat = double.parse(rtept.getAttribute('lat')!);
      final lon = double.parse(rtept.getAttribute('lon')!);

      final descElement = rtept.findElements('desc').firstOrNull;
      final desc = descElement?.text;

      routePoints.add(GPXRoutePoint(lat: lat, lon: lon, desc: desc));
    }
  }

  // Parsing the tracks (trk -> trkseg -> trkpt)
  void _parseTracks(xml.XmlDocument document) {
    final trackElements = document.findAllElements('trk');
    for (final trk in trackElements) {
      final nameElement = trk.findElements('name').firstOrNull;
      final name = nameElement?.text;

      final extensionsElement = trk.findElements('extensions').firstOrNull;
      final travelTimeSecElement = extensionsElement?.findElements('travel_time_sec').firstOrNull;
      final travelDistanceMElement = extensionsElement?.findElements('travel_distance_m').firstOrNull;

      final travelTimeSec = travelTimeSecElement != null ? int.parse(travelTimeSecElement.text) : null;
      final travelDistanceM = travelDistanceMElement != null ? int.parse(travelDistanceMElement.text) : null;

      final trackPoints = <GPXTrackPoint>[];
      final trackPointsElements = trk.findAllElements('trkpt');
      for (final trkpt in trackPointsElements) {
        final lat = double.parse(trkpt.getAttribute('lat')!);
        final lon = double.parse(trkpt.getAttribute('lon')!);

        final eleElement = trkpt.findElements('ele').firstOrNull;
        final timeElement = trkpt.findElements('time').firstOrNull;
        final speedElement = trkpt.findElements('speed').firstOrNull;
        final hdopElement = trkpt.findElements('hdop').firstOrNull;
        final vdopElement = trkpt.findElements('vdop').firstOrNull;

        final ele = eleElement != null ? double.parse(eleElement.text) : null;
        final speed = speedElement != null ? double.parse(speedElement.text) : null;
        final hdop = hdopElement != null ? double.parse(hdopElement.text) : null;
        final vdop = vdopElement != null ? double.parse(vdopElement.text) : null;

        trackPoints.add(GPXTrackPoint(
          coordinates: CoordinatesWithTimestamp.custom(
            latLng: CoordinatesEntityImpl(latitude: lat, longitude: lon),
            timestamp: timeElement != null ? DateTime.parse(timeElement.text) : DateTime.now(),
            altitude: ele?.toInt() ?? 0,
          ),
          elevation: ele,
          speed: speed,
          hdop: hdop,
          vdop: vdop,
        ));
      }

      tracks.add(GPXTrack(
        name: name,
        travelTimeSec: travelTimeSec,
        travelDistanceM: travelDistanceM,
        trackPoints: trackPoints,
      ));
    }
  }
}
