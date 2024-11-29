import 'dart:io';
import 'dart:typed_data';

import 'package:data/extensions.dart';
import 'package:data/models/tour_entity_impl.dart';
import 'package:data/utils/custom_gpx_parser.dart';
import 'package:data/utils/xml_sanitizer.dart';
import 'package:domain/entities/tour_entity.dart';
import 'package:gem_kit/core.dart';

import 'package:gpx/gpx.dart';

class TourBuilder {
  static Future<TourEntity?> build(FileSystemEntity entity, {Uint8List? preview}) async {
    final fileStat = await entity.stat();

    final path = entity.path;
    final size = fileStat.size;

    final rawGpxContent = await File(path).readAsString();
    final gpxContent = sanitizeXmlString(rawGpxContent);

    final gpx = CustomGPXParser(gpxContent);
    if (gpx.routePoints.isEmpty && gpx.tracks.isEmpty) return null;

    final name = path.split('/').last.replaceAll('~', ' ');

    // Variables to store data
    double totalDistance = 0.0;
    double totalUp = 0.0;
    double totalDown = 0.0;
    DateTime? startTime;
    DateTime? endTime;

    int totalDuration = 0;

    // Extract points (trkpts) from the GPX file
    List<GPXTrackPoint> trackPoints = [];
    for (var track in gpx.tracks) {
      trackPoints.addAll(track.trackPoints);
      totalDuration += track.travelTimeSec ?? 0;
    }

    final coordinates = trackPoints.map((wpt) => wpt.coordinates).toList();

    for (int i = 1; i < trackPoints.length; i++) {
      final previousPoint = trackPoints[i - 1];
      final currentPoint = trackPoints[i];

      final prevCoord = previousPoint.coordinates.latLng.toGemCoordinates();
      final currCord = currentPoint.coordinates.latLng.toGemCoordinates();
      final segmentDistance = prevCoord.distance(currCord);

      totalDistance += segmentDistance;

      final elevationChange = (currentPoint.elevation ?? 0) - (previousPoint.elevation ?? 0);

      if (elevationChange > 0) {
        totalUp += elevationChange;
      } else {
        totalDown += elevationChange.abs();
      }

      startTime ??= previousPoint.coordinates.timestamp;
      endTime = currentPoint.coordinates.timestamp;
    }

    final totalTime = endTime != null && startTime != null ? endTime.difference(startTime) : Duration.zero;

    final dateTimeRegExp = RegExp(r"Planned_Tour_(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.\d{6})");
    final match = dateTimeRegExp.firstMatch(path);

    endTime ??= DateTime.now();

    return TourEntityImpl(
        preview: preview,
        coordinates: coordinates,
        name: name,
        filePath: path,
        date: match != null ? match.group(1)! : endTime.toIso8601String(),
        size: size,
        distance: totalDistance.toInt(),
        duration: (totalTime.inSeconds == 0) ? totalDuration : totalTime.inSeconds,
        totalUp: totalUp.toInt(),
        totalDown: totalDown.toInt(),
        type: match != null ? TourTypes.planned : TourTypes.completed);
  }
}

List<DateTime> generateDateTimeList(DateTime startDate, Duration interval, int length) {
  List<DateTime> dateTimeList = [];

  DateTime currentDate = startDate;
  for (int i = 0; i < length; i++) {
    dateTimeList.add(currentDate);
    currentDate = currentDate.add(interval);
  }

  return dateTimeList;
}

extension WptExtension on Wpt {
  Coordinates toGemCoordinates() => Coordinates(latitude: lat!, longitude: lon!);
}
