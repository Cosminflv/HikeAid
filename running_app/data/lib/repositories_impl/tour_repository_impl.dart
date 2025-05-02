import 'package:built_collection/built_collection.dart';
import 'package:domain/repositories/tour_repository.dart';
import 'package:shared/data/coordinates_entity_impl.dart';
import 'package:shared/data/tour_entity_impl.dart';
import 'package:shared/domain/coordinates_entity.dart';
import 'package:shared/domain/tour_entity.dart';

import 'package:openapi/openapi.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:typed_data';

class TourRepositoryImpl extends TourRepository {
  final Openapi _openapi;

  TourRepositoryImpl(this._openapi);

  @override
  Future<bool> insertTour({required TourEntity tour, required Uint8List previewImageBytes}) async {
    try {
      final fileName = '${tour.authorId}${DateTime.now().millisecondsSinceEpoch}${tour.previewImageUrl.hashCode}.jpg';
      final imageUploadUrl = Uri.parse('https://api.cloudinary.com/v1_1/desccolsj/image/upload');
      final request = http.MultipartRequest('POST', imageUploadUrl)
        ..fields['upload_preset'] = 'hikeaid'
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          previewImageBytes,
          filename: fileName,
        ));
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      final uploadedUrl = jsonMap['url'] as String;

      TourDto tourDto = TourDto(
        (builder) {
          builder.name = tour.name;
          builder.authorId = tour.authorId;
          builder.previewImageUrl = uploadedUrl;
          builder.distance = tour.distance;
          builder.duration = tour.duration;
          builder.totalUp = tour.totalUp;
          builder.totalDown = tour.totalDown;
          builder.date = tour.date.toUtc();
          builder.coordinates = ListBuilder<TourCoordinatesDto>(
            tour.coordinates.map((e) => TourCoordinatesDto((b) {
                  b.latitude = e.latLng.latitude;
                  b.longitude = e.latLng.longitude;
                  b.speed = e.speed;
                  b.altitude = e.altitude;
                  b.timestamp = e.timestamp.toUtc();
                })),
          );
        },
      );

      try {
        final result =
            await _openapi.getTourApi().apiTourIdUploadTourPost(id: tour.authorId.toString(), tourDto: tourDto);

        if (result.statusCode != 200) return false;

        final response = result.data as bool;
        return response;
      } catch (e) {
        print("Error uploading tour: $e");
        return false;
      }
    } catch (e) {
      print("Error inserting tour: $e");
      return false;
    }
  }

  @override
  Future<List<TourEntity>?> readTours(int userId) async {
    try {
      final result = await _openapi.getTourApi().apiTourIdUserToursGet(id: userId.toString());

      if (result.statusCode == 200) {
        final response = result.data;
        if (response == null) return null;

        return response.map((e) => mapTourDtoToEntity(e)).toList();
      }
      return null;
    } catch (e) {
      print("Error reading own tours: $e");
      return null;
    }
  }

  TourEntity mapTourDtoToEntity(TourDto dto) {
    // Safely pull the built_value list (which may be null) into a regular Dart list
    final BuiltList<TourCoordinatesDto> dtoCoords = dto.coordinates ?? BuiltList<TourCoordinatesDto>();

    // Map each TourCoordinatesDto to CoordinatesWithTimestamp
    final List<CoordinatesWithTimestamp> coords = dtoCoords.map((c) {
      // Build the lat/lng entity
      final latLng = CoordinatesEntityImpl(
        latitude: c.latitude ?? 0.0,
        longitude: c.longitude ?? 0.0,
      );

      return CoordinatesWithTimestamp(
        latLng as CoordinatesEntity,
        c.speed,
        c.altitude ?? 0,
        c.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
    }).toList();

    return TourEntityImpl(
      id: dto.id ?? 0,
      authorId: dto.authorId ?? 0,
      name: dto.name ?? '',
      date: dto.date ?? DateTime.fromMillisecondsSinceEpoch(0),
      distance: dto.distance ?? 0,
      duration: dto.duration ?? 0,
      totalUp: dto.totalUp ?? 0,
      totalDown: dto.totalDown ?? 0,
      previewImageUrl: dto.previewImageUrl ?? '',
      coordinates: coords,
    );
  }

  @override
  Future<void> delete(TourEntity tour) async {
    // final session = _supabaseInstance.client.auth.currentSession;

    // if (session == null) return;

    // _supabaseInstance.client.rest.setAuth(session.accessToken);

    // await _supabaseInstance.client.rest.from('tours').delete().eq('id', tour.id);
  }

  @override
  Future<void> rename({required TourEntity tour, required String newName}) async {
    // final session = _supabaseInstance.client.auth.currentSession;

    // if (session == null) return;

    // _supabaseInstance.client.rest.setAuth(session.accessToken);

    // await _supabaseInstance.client.rest.from('tours').update({'name': newName}).eq('id', tour.id);
  }
}
